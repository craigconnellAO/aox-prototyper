#!/usr/bin/env bash
#
# install-aox-power.sh — copy the parts of AOX-Prototyper that Kiro's Power
# installer leaves behind.
#
# Kiro copies POWER.md, steering/ and mcp.json into your environment and stops
# there. Skills, hooks, the scan script and the Strata component sheet are not
# copied, and there is no install-script mechanism in a Power to do it. This is
# that mechanism, run by hand or offered by onboarding.
#
# Everything it does is a file copy into your workspace. It never touches
# steering/, never edits a file in place, and backs up anything it would
# overwrite unless you pass --force.
#
# Usage:
#   bash install-aox-power.sh                    install everything into $PWD
#   bash install-aox-power.sh --dry-run          show what would happen
#   bash install-aox-power.sh --only skills      just the skills
#   bash install-aox-power.sh --target ~/proj    install somewhere else
#   bash install-aox-power.sh --source ~/repo    copy from a specific checkout
#   bash install-aox-power.sh --agent claude     install into .claude/ instead
#   bash install-aox-power.sh --uninstall        remove what this script added
#
# Components: skills, hooks, scripts, assets. Default is all four.
#
# Exit codes: 0 = done, 1 = failed, 2 = bad usage.

set -uo pipefail

REPO_URL="https://github.com/craigconnellAO/aox-prototyper.git"
TARGET="$PWD"
SOURCE=""
AGENT="kiro"
ONLY="skills,hooks,scripts,assets"
DRY_RUN=0
FORCE=0
UNINSTALL=0
CLONED_TMP=""
STAMP="$(date '+%Y%m%d-%H%M%S')"

RED=""; GRN=""; YLW=""; DIM=""; RST=""
if [ -t 1 ]; then
  RED=$'\033[31m'; GRN=$'\033[32m'; YLW=$'\033[33m'; DIM=$'\033[2m'; RST=$'\033[0m'
fi

say()  { printf '%s\n' "$*"; }
ok()   { printf '  %s✓%s %s\n' "$GRN" "$RST" "$*"; }
skip() { printf '  %s·%s %s\n' "$DIM" "$RST" "$*"; }
warn() { printf '  %s!%s %s\n' "$YLW" "$RST" "$*"; }
die()  { printf '%serror:%s %s\n' "$RED" "$RST" "$*" >&2; cleanup; exit 1; }

cleanup() { [ -n "$CLONED_TMP" ] && rm -rf "$CLONED_TMP"; }
trap cleanup EXIT

usage() { sed -n '2,30p' "$0" | sed 's/^# \{0,1\}//'; exit "${1:-0}"; }

while [ $# -gt 0 ]; do
  case "$1" in
    --target)    TARGET="${2:-}"; shift ;;
    --source)    SOURCE="${2:-}"; shift ;;
    --only)      ONLY="${2:-}"; shift ;;
    --agent)     AGENT="${2:-}"; shift ;;
    --dry-run|-n) DRY_RUN=1 ;;
    --force)     FORCE=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help)   usage 0 ;;
    *)           printf 'unknown option: %s\n\n' "$1" >&2; usage 2 ;;
  esac
  shift
done

case "$AGENT" in
  kiro)   AGENT_DIR=".kiro" ;;
  claude) AGENT_DIR=".claude" ;;
  *)      die "--agent must be 'kiro' or 'claude' (got '$AGENT')" ;;
esac

[ -d "$TARGET" ] || die "target directory does not exist: $TARGET"
TARGET="$(cd "$TARGET" && pwd)"

wants() { case ",$ONLY," in *",$1,"*) return 0 ;; *) return 1 ;; esac; }

# --- source resolution -------------------------------------------------------
# A valid source is any directory holding this repo's POWER.md alongside the
# folders the Power installer doesn't copy.

is_valid_source() {
  [ -n "${1:-}" ] && [ -f "$1/POWER.md" ] && [ -d "$1/skills" ]
}

resolve_source() {
  local here candidate
  here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  for candidate in \
    "$SOURCE" \
    "${AOX_POWER_SOURCE:-}" \
    "$here/.." \
    "$HOME/.kiro/powers/repos/aox-prototyper" \
    "$HOME/.kiro/powers/installed/aox-prototyper" \
    "$HOME/.claude/powers/repos/aox-prototyper" \
    "$PWD"
  do
    if is_valid_source "$candidate"; then
      (cd "$candidate" && pwd)
      return 0
    fi
  done

  # Any similarly-named checkout under the powers directories.
  for candidate in "$HOME"/.kiro/powers/*/*aox-prototyper*; do
    if is_valid_source "$candidate"; then
      (cd "$candidate" && pwd)
      return 0
    fi
  done

  # Last resort: a shallow clone. Only reached when the Power was installed
  # without its repo kept alongside it.
  if command -v git >/dev/null 2>&1; then
    say "No local AOX-Prototyper checkout found. Fetching a shallow clone…"
    CLONED_TMP="$(mktemp -d 2>/dev/null || mktemp -d -t aoxpower)"
    if git clone --depth 1 --quiet "$REPO_URL" "$CLONED_TMP/aox-prototyper" 2>/dev/null \
       && is_valid_source "$CLONED_TMP/aox-prototyper"; then
      echo "$CLONED_TMP/aox-prototyper"
      return 0
    fi
  fi
  return 1
}

# --- copy helpers ------------------------------------------------------------
# Every write goes through here so --dry-run is honest and nothing is
# overwritten without a backup.

copy_file() {
  local src="$1" dst="$2" label="$3"
  if [ -e "$dst" ]; then
    if cmp -s "$src" "$dst"; then
      skip "$label — already up to date"
      return 0
    fi
    if [ "$FORCE" -eq 0 ]; then
      if [ "$DRY_RUN" -eq 0 ]; then
        cp "$dst" "$dst.bak.$STAMP" || die "could not back up $dst"
      fi
      warn "$label — differs; existing copy kept as $(basename "$dst").bak.$STAMP"
    else
      warn "$label — overwritten (--force)"
    fi
  else
    ok "$label"
  fi
  if [ "$DRY_RUN" -eq 0 ]; then
    mkdir -p "$(dirname "$dst")" || die "could not create $(dirname "$dst")"
    cp "$src" "$dst" || die "could not write $dst"
  fi
  return 0
}

copy_tree() {
  local src="$1" dst="$2" label="$3" f rel
  [ -d "$src" ] || { warn "$label — not present in source, skipped"; return 0; }
  while IFS= read -r f; do
    rel="${f#"$src"/}"
    copy_file "$f" "$dst/$rel" "$label/$rel"
  done < <(find "$src" -type f -not -name '.DS_Store' | sort)
}

remove_path() {
  local p="$1" label="$2"
  if [ -e "$p" ]; then
    ok "removed $label"
    [ "$DRY_RUN" -eq 0 ] && rm -rf "$p"
  else
    skip "$label — not present"
  fi
}

# --- go ----------------------------------------------------------------------

SOURCE_RESOLVED=""
if [ "$UNINSTALL" -eq 0 ]; then
  SOURCE_RESOLVED="$(resolve_source)" || die \
"could not find the AOX-Prototyper repo to copy from.

Pass it explicitly:
  bash install-aox-power.sh --source /path/to/aox-prototyper

It's usually at ~/.kiro/powers/repos/aox-prototyper after installing the Power,
or wherever you cloned $REPO_URL."
fi

say ""
if [ "$UNINSTALL" -eq 1 ]; then
  say "AOX-Prototyper — uninstalling from $TARGET"
else
  say "AOX-Prototyper — installing into $TARGET"
  say "${DIM}source: $SOURCE_RESOLVED${RST}"
fi
[ "$DRY_RUN" -eq 1 ] && say "${YLW}dry run — nothing will be written${RST}"
say ""

if [ "$UNINSTALL" -eq 1 ]; then
  say "Skills"
  for s in figma-bridge ideation ideate-mode; do
    remove_path "$TARGET/$AGENT_DIR/skills/$s" "$AGENT_DIR/skills/$s"
  done
  say ""
  say "Hooks"
  for h in design-system-scan design-system-review design-system-review-on-stop design-system-guard; do
    remove_path "$TARGET/$AGENT_DIR/hooks/$h.kiro.hook" "$AGENT_DIR/hooks/$h.kiro.hook"
  done
  say ""
  say "Scripts & assets"
  remove_path "$TARGET/$AGENT_DIR/scripts/ds-scan.sh" "$AGENT_DIR/scripts/ds-scan.sh"
  remove_path "$TARGET/$AGENT_DIR/ds-guard-report.md" "$AGENT_DIR/ds-guard-report.md"
  remove_path "$TARGET/assets/strata-component-sheet" "assets/strata-component-sheet"
  say ""
  say "Done. Backups (*.bak.*) and your project files were left alone."
  exit 0
fi

INSTALLED_HOOKS=0

if wants skills; then
  say "Skills → $AGENT_DIR/skills/"
  copy_tree "$SOURCE_RESOLVED/skills" "$TARGET/$AGENT_DIR/skills" "skills"
  say ""
fi

if wants hooks; then
  if [ "$AGENT" = "claude" ]; then
    say "Hooks"
    warn "skipped — .kiro.hook files are Kiro-specific; Claude Code configures hooks in settings.json"
    say ""
  else
    say "Hooks → $AGENT_DIR/hooks/"
    # The v1.2 guard hook fired an agent review on every single HTML save. It's
    # superseded by the free scan + on-demand review pair; retire it rather than
    # leaving both installed and firing.
    legacy="$TARGET/$AGENT_DIR/hooks/design-system-guard.kiro.hook"
    if [ -e "$legacy" ]; then
      warn "design-system-guard.kiro.hook — retired, moved to design-system-guard.kiro.hook.replaced.$STAMP"
      warn "  (it ran an agent review on every save; the scan + review pair replaces it)"
      [ "$DRY_RUN" -eq 0 ] && mv "$legacy" "$legacy.replaced.$STAMP"
    fi
    for f in "$SOURCE_RESOLVED"/hooks/*.kiro.hook; do
      [ -e "$f" ] || continue
      copy_file "$f" "$TARGET/$AGENT_DIR/hooks/$(basename "$f")" "hooks/$(basename "$f")"
      INSTALLED_HOOKS=1
    done
    say ""
  fi
fi

if wants scripts; then
  say "Scripts → $AGENT_DIR/scripts/"
  copy_file "$SOURCE_RESOLVED/scripts/ds-scan.sh" "$TARGET/$AGENT_DIR/scripts/ds-scan.sh" "scripts/ds-scan.sh"
  [ "$DRY_RUN" -eq 0 ] && chmod +x "$TARGET/$AGENT_DIR/scripts/ds-scan.sh" 2>/dev/null
  say ""
elif [ "$INSTALLED_HOOKS" -eq 1 ]; then
  warn "hooks installed without scripts — the scan hook calls $AGENT_DIR/scripts/ds-scan.sh and will fail until you add it"
  say ""
fi

if wants assets; then
  # This one lands at the workspace root rather than under .kiro/, because
  # steering/aox-design-system.md refers to it as assets/strata-component-sheet/
  # and Protocol 1 tells the agent to read it before writing any screen.
  say "Component sheet → assets/strata-component-sheet/"
  copy_tree "$SOURCE_RESOLVED/assets/strata-component-sheet" \
            "$TARGET/assets/strata-component-sheet" "assets/strata-component-sheet"
  say ""
fi

if [ "$DRY_RUN" -eq 1 ]; then
  say "Dry run complete — nothing was written. Drop --dry-run to apply."
  exit 0
fi

say "Done."
say ""
say "  Skills      /ideate-mode, plus the figma-bridge and ideation skills"
say "  Scan        runs free on every HTML save, writes $AGENT_DIR/ds-guard-report.md"
say "  Review      run \"Design System Review\" from the Agent Hooks panel when a"
say "              screen or flow is ready — that's the one that costs credits"
say ""
say "${DIM}Kiro picks up new hooks and skills on reload. If they don't appear, reopen the workspace.${RST}"
