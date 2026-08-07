---
inclusion: always
---

# AOX-Prototyper — Workspace Rules

## Project Purpose

**AOX-Prototyper** is a Kiro Power distribution within the larger **AOX-DesignSystem** initiative. This workspace produces AOX-compliant HTML prototypes and Figma builds, suitable for handing directly to developers — class names, token names, and `data-aods` selectors map 1:1 to the production `@ao/components` React library.

Source of truth, in order of authority:

1. **`steering/design.md`** — tokens, typography, component blueprints, patterns, anti-patterns. Non-negotiable.
2. **`steering/brand.md`** — AO brand guidelines (voice, colour, logo, graphic language).
3. **`assets/strata-component-sheet/index.html`** — the real, rendered Strata markup. When a component's exact HTML/CSS is in question, this file is authoritative over prose descriptions in `design.md`.
4. **A project's own `DESIGN.md` / `PRODUCT.md` / `DISCOVERY.md`** (see `templates/`) — locked decisions and context specific to that project. These extend `design.md`, never contradict it, unless the contradiction is explicitly resolved and recorded (see `design.md` §7a for the pattern).

---

## Output Format

- Single self-contained HTML file with inline `<style>` block, unless a project specifies otherwise
- Semantic HTML (`<nav>`, `<main>`, `<section>`, `<button>`, `<label>`)
- Mobile-first layout, breakpoints: `sm: 544px`, `md: 768px`, `lg: 990px`, `xl: 1200px`
- Every generated stylesheet includes the `:root` token block from `design.md` §8 and the `@font-face` block from `design.md`'s typography section
- Every generated HTML includes the Strata icons stylesheet link (see `design.md`)
- Every component root carries `data-aods="component-name"`

## Token Rules (Non-Negotiable)

- Every colour, spacing value, radius, and shadow references a named token. No raw hex, no inline magic numbers.
- Two fonts only: SmileyFace Bold for headings and all button labels, Inter for everything else. SmileyFace never below 14px.
- Approved variants only (buttons, tags, etc. — see `design.md`). If a screen needs something not in the system, stop and ask rather than inventing it.

---

## Protocols

These four rules exist because they were the concrete, repeated failure modes surfaced by a `/insights` review of this workspace's session history (2026-05 to 2026-07, 35 sessions). Each protocol maps to a specific recurring problem — keep that mapping in mind rather than treating these as generic advice.

### 1. Resolve-before-build

**Problem this fixes:** Claude repeatedly hand-drew SVG icons instead of using the real Strata icon font, grabbed the wrong header variant (e.g. checkout-style instead of core), and pulled a stale AO logo path out of `design.md` prose instead of the correct component-sheet markup. Each mistake cost a full correction round ("Not that one. This one.").

**Rule:** Before writing any screen or component, resolve the exact markup you will use for the header, icons, and logo from `assets/strata-component-sheet/index.html` and `design.md` — never from prose descriptions, memory, or invented SVGs. For anything non-trivial (a full screen, a new flow), state which header variant, which icon glyphs, and which logo asset you're using, before writing code. Never hand-draw an icon that exists in the Strata icon font.

**If `assets/strata-component-sheet/index.html` isn't in the workspace, say so before you build, not after.** The Power installer doesn't copy it, so on a fresh workspace this rule routinely points at nothing — and building anyway, from memory, is precisely the failure it exists to prevent. Offer to run `scripts/install-aox-power.sh` (see `steering/onboarding-flow.md` → *Installing skills, hooks and the component sheet*). If the user would rather press on without it, build from `design.md` alone and name every piece of markup you couldn't verify.

### 2. Verify-or-flag

**Problem this fixes:** Preview panes and browser tooling went unresponsive mid-session more than once; output got shipped without the usual visual diff against the reference, and the mismatch surfaced only when the user caught it later.

**Rule:** After building or editing any HTML/prototype screen, run a visual verification pass (preview + screenshot) against the reference design before declaring the work done. If the verification tooling is unavailable or misbehaving, say so explicitly and name exactly what remains unverified — don't silently ship unverified output as if it were checked.

### 3. Resilient-Figma

**Problem this fixes:** Figma Desktop Bridge drops, 403 auth errors, and session limits repeatedly interrupted builds mid-flow, sometimes losing an entire heavy build's progress.

**Rule:** Before starting a heavy Figma build, confirm the Figma MCP connection is live. If it drops or errors mid-build, don't retry indefinitely — say so immediately, and continue with local/HTML work rather than stalling. See `skills/figma-bridge/SKILL.md` for the full protocol (chunked builds, checkpointing, retry limits).

### 4. Concise-by-default

**Problem this fixes:** Verbose walls of text on analysis/review/merge tasks required the user to explicitly ask for condensing, more than once.

**Rule:** For analysis, review, research-merge, or status-update tasks, lead with an itemized executive summary — not a wall of prose. Offer full detail on request rather than by default.

---

## Project Setup

A project's `DISCOVERY.md`, `PRODUCT.md`, and `DESIGN.md` are what make generated output specific to *this* project rather than generically AOX-correct. If they're missing or still carry the `AOX-PROTOTYPER: This template is unfilled` marker, `steering/onboarding-flow.md` governs what to do — it's self-gating, so it stays dormant once they're filled.

`STATUS.md`, if present, is agent-maintained. Keep it current as milestones land; there's no hook or script behind it.

---

## Tool Boundaries — what may write where

Two tiers, and the line between them is not negotiable:

- **System tier** — `steering/design.md`, `steering/brand.md`, this file. Org-wide, shared across every project. Changes here affect work you cannot see.
- **Project tier** — `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`, `IDEATION.md`, `STATUS.md`, prototypes. Local to one project.

**Companion tools — impeccable above all — operate on the project tier only.** Never let a craft, polish, audit, or critique pass edit a system-tier file, and never fold its output into `design.md` as though it were a system decision.

In normal use this is structural rather than a matter of discipline: an installed Power's `steering/` lives outside the workspace, so a project-level tool physically cannot reach it. The rule matters in one case — **when the workspace *is* the power repo**, where `steering/` is an ordinary editable file. In that situation, treat every system-tier file as read-only unless the user has explicitly asked to change the design system itself. Editing `design.md` because a polish pass suggested a nicer value is exactly the failure this rule exists to prevent.

A project-tier decision that genuinely deserves to be system-wide has a route. See *Promoting a Project Decision* below. Take that route; don't shortcut it.

---

## Ideate vs. Locked

Default mode is **locked**: build strictly from `design.md`, the project's `DESIGN.md`, and approved variants. Deliberately entering exploratory/creative territory (new motion, new layout structure, a genuinely new screen concept) requires invoking `/ideate-mode` first — see `skills/ideate-mode/SKILL.md`. Don't let exploratory decisions leak into a project's locked `DESIGN.md` without going through that skill; that's the exact failure `/ideate-mode` exists to prevent.

---

## Promoting a Project Decision into the System

Sometimes a project-tier decision turns out to be right for everyone — a colour the system lacks, a component pattern that keeps getting rebuilt, a rule that stops a recurring mistake. It gets promoted **deliberately and in writing**, never by quietly editing `design.md` mid-build.

There's a worked precedent. `--switch-purple` was used in a Switch24 prototype, flagged in that project's `FIGMA-BRIDGE.md` as a conflict against the project's own "introduces no new colours" rule, and only then adopted into `design.md` §7a with an explicit scope — account hub only, not the signup funnel. It was a real exception, argued for and bounded, not a value that drifted in.

Follow that shape:

1. **Keep it local first.** It lives in the project's `DESIGN.md` (locked) or `IDEATION.md` (still open). A decision that has only been used once has not yet earned generalisation.
2. **State the case.** What is it, what problem does it solve, and where has it actually been used? Two or more projects reaching for the same thing is the strongest signal there is; one project wanting it is a local decision.
3. **Check it isn't already solvable.** Most "we need a new component" turns out to be an existing blueprint with different content. Resolve against `design.md` and `assets/strata-component-sheet/index.html` before proposing anything new.
4. **Get a human decision.** Promotion changes shared, org-wide files. Never do it because a tool suggested it, an audit flagged it, or it seemed tidy — only because the user explicitly asked for it.
5. **Write it in the right home**, with scope:
   - A colour or sub-brand accent → `design.md` §7a, following that section's pattern exactly: token + hex + bg/border pair + the precise surfaces it applies to.
   - A component or pattern → the relevant `design.md` section, with a blueprint, its variant API, and the anti-pattern it replaces.
   - A recurring process failure → a protocol in this file, stated as *problem this fixes* then *rule*, like the four above.
6. **Record it in the changelog**, and update the originating project's `DESIGN.md` to reference the now-sanctioned version rather than continuing to describe it as a local override.

An exception that isn't scoped isn't an exception — it's the palette quietly getting wider. If step 5 can't name the surfaces it applies to, it isn't ready.
