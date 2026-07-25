---
inclusion: always
---

# AO designMD — Workspace Rules

## Project Purpose

This workspace produces AO (ao.com) design-system-strict HTML prototypes and Figma builds. Output is intended to be handed directly to developers — class names, token names, and `data-aods` selectors map 1:1 to the production `@ao/components` React library.

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

## Ideate vs. Locked

Default mode is **locked**: build strictly from `design.md`, the project's `DESIGN.md`, and approved variants. Deliberately entering exploratory/creative territory (new motion, new layout structure, a genuinely new screen concept) requires invoking `/ideate-mode` first — see `skills/ideate-mode/SKILL.md`. Don't let exploratory decisions leak into a project's locked `DESIGN.md` without going through that skill; that's the exact failure `/ideate-mode` exists to prevent.
