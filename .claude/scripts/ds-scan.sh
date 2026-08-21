#!/usr/bin/env bash
#
# ds-scan.sh — deterministic design-system scan for AOX prototypes.
#
# This is the cheap half of the design-system guard. It runs on every HTML save,
# costs no model credits, and finishes in milliseconds. It only finds the two
# mechanical failure modes:
#
#   1. raw hex colour values outside the :root token block
#   2. inline <svg> elements that may be standing in for a Strata icon
#
# It does not judge, fix, or explain — that's the agent's job, and it happens
# once, on demand, via the "Design System Review" hook, which reads the report
# this script writes.
#
# Usage:
#   ds-scan.sh                  scan every candidate .html file under the workspace
#   ds-scan.sh a.html b.html    scan only these files
#   ds-scan.sh --quiet          write the report, print only the one-line summary
#   ds-scan.sh --no-report      print findings, don't write the report file
#
# Exit codes: 0 = clean, 1 = findings, 2 = bad usage.
#
# Suppressing a legitimate case: put `ds-allow` in the element or on the line
# above it, e.g. `<svg data-ds-allow="brand logo" …>`. Genuine logos, sprite
# sheets, and illustrations are the expected users of this.

set -uo pipefail

WORKSPACE="${AOX_WORKSPACE:-$PWD}"
REPORT="$WORKSPACE/.kiro/ds-guard-report.md"
QUIET=0
WRITE_REPORT=1
FILES=()

while [ $# -gt 0 ]; do
  case "$1" in
    --quiet)     QUIET=1 ;;
    --no-report) WRITE_REPORT=0 ;;
    -h|--help)   sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*)          echo "ds-scan: unknown option $1" >&2; exit 2 ;;
    *)           FILES+=("$1") ;;
  esac
  shift
done

# Default target set: every .html in the workspace except vendored, generated,
# and reference material. The component sheet is authoritative markup, not a
# prototype — scanning it produces nothing but noise.
if [ ${#FILES[@]} -eq 0 ]; then
  while IFS= read -r f; do FILES+=("$f"); done < <(
    find "$WORKSPACE" -type f -name '*.html' \
      -not -path '*/node_modules/*' \
      -not -path '*/.git/*' \
      -not -path '*/.kiro/*' \
      -not -path '*/assets/strata-component-sheet/*' \
      -not -path '*/example-switch24/*' \
      -not -path '*/dist/*' \
      -not -path '*/build/*' \
      2>/dev/null | sort
  )
fi

if [ ${#FILES[@]} -eq 0 ]; then
  [ "$QUIET" -eq 1 ] || echo "ds-scan: no HTML prototypes found under $WORKSPACE"
  exit 0
fi

scan_one() {
  # Emits one finding per line: "<kind>\t<line>\t<excerpt>"
  awk '
    {
      # Comments run first and unconditionally — the multi-line state machine
      # must see every line, including ones the :root block below skips.
      clean = strip_comments($0)
      allowed = ($0 ~ /ds-allow/ || prev ~ /ds-allow/)
      prev = $0

      # Track the :root token block — hex values are *defined* there, which is
      # the one place they are supposed to appear. Same for @font-face.
      line = clean
      if (!in_exempt && (line ~ /:root[^{]*\{/ || line ~ /@font-face[^{]*\{/)) {
        in_exempt = 1
        depth = 0
        sub(/^.*(:root|@font-face)[^{]*/, "", line)
      }
      if (in_exempt) {
        n = gsub(/\{/, "{", line); depth += n
        n = gsub(/\}/, "}", line); depth -= n
        if (depth <= 0) in_exempt = 0
        next
      }

      if (allowed) next

      # ---- check 1: raw hex colours ----
      probe = clean
      # Strip things that legitimately contain a # but are not colours.
      gsub(/href="#[^"]*"/, "", probe)
      gsub(/href='"'"'#[^'"'"']*'"'"'/, "", probe)
      gsub(/url\(#[^)]*\)/, "", probe)
      gsub(/id="[^"]*"/, "", probe)

      rest = probe
      while (match(rest, /#[0-9a-fA-F]+/)) {
        tok = substr(rest, RSTART, RLENGTH)
        len = RLENGTH - 1
        after = substr(rest, RSTART + RLENGTH, 1)
        # Valid CSS hex lengths only, and not part of a longer identifier.
        if ((len == 3 || len == 4 || len == 6 || len == 8) && after !~ /[0-9a-zA-Z_-]/) {
          print "hex\t" NR "\t" tok "\t" trim($0)
          break
        }
        rest = substr(rest, RSTART + RLENGTH)
      }

      # ---- check 2: inline SVG that may be replacing a Strata icon ----
      if (clean ~ /<svg/)
        print "svg\t" NR "\t<svg>\t" trim($0)
    }

    function trim(s) {
      gsub(/^[ \t]+|[ \t]+$/, "", s)
      if (length(s) > 96) s = substr(s, 1, 96) "…"
      return s
    }

    # Comments document tokens as often as they use them — a line reading
    # "/* --ui-success-accent (#00893e) */" is not a violation. Strips both
    # CSS and HTML comments, including ones that span lines.
    function strip_comments(s,   out, i) {
      if (in_css_comment) {
        i = index(s, "*/")
        if (i == 0) return ""
        in_css_comment = 0
        s = substr(s, i + 2)
      }
      if (in_html_comment) {
        i = index(s, "-->")
        if (i == 0) return ""
        in_html_comment = 0
        s = substr(s, i + 3)
      }
      gsub(/\/\*.*\*\//, "", s)
      gsub(/<!--.*-->/, "", s)
      if (index(s, "/*") > 0) { in_css_comment = 1;  sub(/\/\*.*$/, "", s) }
      if (index(s, "<!--") > 0) { in_html_comment = 1; sub(/<!--.*$/, "", s) }
      return s
    }
  ' "$1"
}

total_hex=0
total_svg=0
files_with_findings=0
console=""
report_body=""

for f in "${FILES[@]}"; do
  [ -f "$f" ] || continue
  findings="$(scan_one "$f")"
  [ -z "$findings" ] && continue

  files_with_findings=$((files_with_findings + 1))
  rel="${f#"$WORKSPACE"/}"
  console+="$rel"$'\n'
  report_body+="### \`$rel\`"$'\n\n'

  while IFS=$'\t' read -r kind line tok excerpt; do
    [ -z "$kind" ] && continue
    case "$kind" in
      hex)
        total_hex=$((total_hex + 1))
        console+="  hex  L${line}  ${tok}  → use a design.md token"$'\n'
        report_body+="- **hex** \`L${line}\` \`${tok}\` — should be a \`design.md\` token"$'\n'
        report_body+="  \`\`\`"$'\n'"  ${excerpt}"$'\n'"  \`\`\`"$'\n'
        ;;
      svg)
        total_svg=$((total_svg + 1))
        console+="  svg  L${line}  → confirm this isn't a Strata icon"$'\n'
        report_body+="- **svg** \`L${line}\` — confirm this isn't a Strata icon-font glyph"$'\n'
        report_body+="  \`\`\`"$'\n'"  ${excerpt}"$'\n'"  \`\`\`"$'\n'
        ;;
    esac
  done <<< "$findings"

  report_body+=$'\n'
done

total=$((total_hex + total_svg))

if [ "$WRITE_REPORT" -eq 1 ]; then
  mkdir -p "$(dirname "$REPORT")" 2>/dev/null
  {
    echo "# Design System Scan"
    echo
    echo "*Generated by \`.kiro/scripts/ds-scan.sh\` — $(date '+%Y-%m-%d %H:%M'). Machine-written; edits are overwritten.*"
    echo
    echo "Scanned ${#FILES[@]} file(s). **$total finding(s)** across $files_with_findings file(s) — $total_hex raw hex, $total_svg inline \`<svg>\`."
    echo
    if [ "$total" -eq 0 ]; then
      echo "No mechanical findings. Nothing for the review hook to look at."
    else
      echo "These are candidates, not verdicts — a brand logo or an illustration is a legitimate"
      echo "\`<svg>\`, and \`#fff\` inside the \`:root\` block is where hex is *supposed* to live."
      echo "Run the **Design System Review** hook to have them judged. Mark a settled one with"
      echo "\`ds-allow\` on the element and it stops being reported."
      echo
      printf '%s' "$report_body"
    fi
  } > "$REPORT"
fi

if [ "$total" -eq 0 ]; then
  [ "$QUIET" -eq 1 ] || echo "ds-scan: clean — ${#FILES[@]} file(s), no findings."
  exit 0
fi

if [ "$QUIET" -eq 0 ]; then
  printf '%s' "$console"
  echo
fi
echo "ds-scan: $total finding(s) in $files_with_findings file(s) ($total_hex hex, $total_svg svg). Run the Design System Review hook when this piece of work is ready."
exit 1
