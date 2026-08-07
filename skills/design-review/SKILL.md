---
name: design-review
description: Run a full AOX design-system compliance review over a finished screen or flow — raw hex instead of tokens, hand-drawn SVGs instead of Strata icons, wrong header variant, off-scale spacing, missing data-aods. Trigger when a prototype is done and ready to be checked, when the user asks to review/audit/check compliance of a prototype, or before pushing to Figma or handing to a developer. Do NOT trigger mid-build, after each edit, or on a file still being written.
user-invocable: true
argument-hint: "[file or flow name]"
---

# /design-review: compliance pass over finished work

The expensive half of the design-system guard. Everything mechanical has already been done for free by `.kiro/scripts/ds-scan.sh` on save — this skill judges those findings and adds what a grep can't.

**The trigger discipline is the point.** Run this when a screen or flow is *finished*. Reviewing markup mid-write is close to worthless: the file is supposed to be wrong at that point, and the review costs the same either way. One pass over completed work catches more than a dozen passes over half-written work.

This is the same review the **Design System Review** hook runs. Use whichever is to hand — the skill also works when hooks aren't installed, and in Claude Code, where `.kiro.hook` files don't apply.

## 1. Refresh the mechanical scan

```bash
bash .kiro/scripts/ds-scan.sh --quiet
```

Then read `.kiro/ds-guard-report.md`.

If the script isn't there, the workspace hasn't had `scripts/install-aox-power.sh` run against it. Say so, offer to run it, and do the hex/SVG pass yourself this once — don't silently skip it.

If the report shows zero findings, skip to §3 rather than re-deriving the scan by reading files yourself.

## 2. Judge the findings

The script flags candidates, not violations. For each:

- **raw hex** — a violation unless it has no token equivalent. Name the correct `steering/design.md` token in the fix. (`:root`, `@font-face` and comments are already exempt, so anything reported is in live styling.)
- **inline `<svg>`** — a violation *only* when it stands in for a glyph that exists in the Strata icon font. Check `assets/strata-component-sheet/index.html` before deciding. Logos, sprite sheets, spinners and illustrations are legitimate — say so, and suggest marking them `data-ds-allow="reason"` so they stop being reported.

## 3. The checks a grep can't make

Only on the files that changed, and only where you can point at a specific line:

| Check | Against |
|---|---|
| Header / nav / footer / logo markup | `assets/strata-component-sheet/index.html` — the wrong header variant is the single most common failure (Protocol 1) |
| SmileyFace Bold on every heading and button label, never below 14px; Inter elsewhere | `steering/design.md` |
| Spacing on the scale: 4, 8, 12, 16, 20, 24, 32, 40, 48, 56, 64 | `steering/design.md` |
| Radius on the named scale (xs/sm/md/xl/2xl) | `steering/design.md` |
| `data-aods` on every component root | `steering/aox-design-system.md` |
| Approved component variants only — no invented states | `steering/design.md` |
| Locked decisions honoured | the project's `DESIGN.md` |

## 4. Report

Lead with a one-line verdict, then group by file with line numbers, each finding as *what's there → what it should be*.

**Do not edit anything.** This reports; the user decides. Offer to apply the fixes as a follow-up — and if they accept, apply them as ordinary edits, not as part of this pass.

If the work is clean, say so in a sentence and stop. No summary of everything you checked.

## Boundaries

- Prototype files only. Never edit `steering/` — see *Tool Boundaries* in `steering/aox-design-system.md`.
- A project's `DESIGN.md` extends `steering/design.md`; it never overrides it. A conflict is a finding, not a licence.
- A genuinely missing token or component is a `/ideate-mode` conversation or a promotion request, not something to invent here.

## Afterwards

Tick *Ran a design-system review* in `STATUS.md`, and *Prototype uses tokens, Strata icons, and `data-aods` throughout* if the pass came back clean.
