# Changelog

## v1.2.0 — 2026-07-28

**Figma bridge resolution fix:** AOX component library facts moved from unreachable example files into shareable steering.

### What changed

- **New `steering/figma-library.md`** — component keys (Design System 2025 `vKoPePlSP1xhVxOuFXTJdB`), icon mappings, exact font `fontName` objects (space in `Smiley Face` et al.), colour map, and a "no DS component exists for" list (card, breadcrumb, notice, progress bar, tags, demo bar). This is now the single source of truth for AOX Figma facts, survives Power install, and all projects reference it.
- **New `templates/FIGMA-BRIDGE.md`** — scaffold for new projects to copy and fill once at project start. Pre-populated with AOX defaults, includes placeholder rows for project-specific overrides.
- **Updated `skills/figma-bridge/SKILL.md`** — removed all AOX-specific component keys, font maps, and icon lists (moved to `steering/figma-library.md`). Added explicit guidance for component search: `figma_search_components`, `figma_get_library_components`, `search_design_system` MCP tool. Fixed stale path `ao-design-system.md` → `aox-design-system.md`. Skill now carries **method only**; projects reference `steering/figma-library.md` for the AOX baseline.
- **Updated `docs/how-to-use.md` § 8** — step-by-step for Figma push: copy template, fill target file, consult `steering/figma-library.md`, run skill.

### Why this matters

The test run (PrototyperTest_3_Marked) produced good HTML but Figma push degraded to hand-drawn primitives — component keys were in an unreachable example file (`example-switch24/FIGMA-BRIDGE.md`), so the bridge had no library knowledge. Kiro's installer copies only `POWER.md`, `steering/`, and `mcp.json`; it doesn't copy `example-switch24/` or `skills/`. Moving the durable facts into `steering/` closes the gap. Projects still get a `FIGMA-BRIDGE.md` template, but it's now a **working record** (target file, any project tweaks, push log) rather than the memory store (component keys, fonts) — that stays global in steering.

### Files not changed

- `example-switch24/FIGMA-BRIDGE.md` is kept as a **worked example** (what a completed push log looks like), not as the template for new projects.
- `POWER.md` and `README.md` clarified to reference the new structure.

---

## v1.0.0 — 2026-07-25

First release as **AO designMD**, a standalone shareable Kiro Power. This is a new package assembled from roughly three months of internal experimentation (originally "AO Figma Make Kit") — not a continuation of that repo's version numbers. See **Lineage** below for how it got here.

### Package structure

Reorganised around three tiers, reflecting how the content actually gets used:

- **Locked steering** (`steering/`) — org-wide, rarely changes: `design.md` (tokens/typography/components/patterns/anti-patterns), `brand.md` (AO brand guidelines), and a new `ao-design-system.md` workspace-rules file.
- **Project templates** (`templates/`) — `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`, blank, to be filled in at the start of each new project's spec.
- **Skills** (`skills/`) — reusable workflows, each a proper Kiro `SKILL.md`: `figma-bridge`, `ideation`, and `ideate-mode`.

Plus a worked example (`example-switch24/`) — the filled Switch24 project, kept as the proof the system works end to end — and a Figma MCP config (`mcp.json`).

### `/insights` findings folded in

A Claude Code `/insights` review of this workspace's session history (2026-05-02 to 2026-07-19, 35 sessions) surfaced four recurring friction patterns. Each is now an explicit, named protocol in `steering/ao-design-system.md`, rather than left as tacit knowledge:

- **Resolve-before-build** — Claude repeatedly hand-drew SVG icons, grabbed the wrong header variant, and pulled stale logo paths from prose instead of the real component markup. Fix: `assets/strata-component-sheet/` is now bundled as an authoritative markup reference, and the protocol requires resolving exact markup before writing a screen.
- **Verify-or-flag** — output occasionally shipped without the usual visual diff when preview tooling broke. Fix: verification is now a stated required step, with an explicit "flag what's unverified" fallback instead of silent shipping.
- **Resilient-Figma** — Figma Desktop Bridge drops, 403s, and session limits repeatedly interrupted builds and lost progress. Fix: `skills/figma-bridge/SKILL.md` now includes a checkpoint-before-build / don't-retry-indefinitely protocol.
- **Concise-by-default** — verbose output on analysis/review tasks needed explicit correction more than once. Fix: now a standing rule rather than a per-session ask.

Also acted on: a **`design-system-guard` hook** (`hooks/design-system-guard.kiro.hook`) that flags hand-drawn `<svg>` and raw hex on file save — a direct response to the same fidelity-rework pattern `/insights` identified as the single largest friction category in this workspace.

### Switch24 sub-brand purple — resolved

`--switch-purple` (`#8023bd`) had been used in the account-switch-hub prototype and flagged in the old `FIGMA-BRIDGE.md` as an undocumented conflict against the "Switch introduces no new colours" rule. Resolved: adopted as a sanctioned sub-brand exception, added to `design.md` §7a with its bg/border pair and an explicit scope (account hub only, not the core signup funnel). `example-switch24/DESIGN.md`'s colour-strategy section updated to reference the resolution instead of contradicting it. (A second candidate value, `#6f3ff5`, appeared only in historical changelog prose for an abandoned earlier attempt and was not adopted.)

### Files retained, archived, or cut

Everything below was evaluated against "does a new project starting from scratch need this." Originals are untouched in their source repositories — this package is a curated copy, not a move.

**Retained (in this package):**
- `design.md` (145 KB, canonical — verified byte-identical between its two source copies) → `steering/design.md`
- `BRAND.md` → `steering/brand.md`
- The six-file steering split (`DESIGN.md`/`DISCOVERY.md`/`PRODUCT.md`/`FIGMA-BRIDGE.md`/`IDEATION.md`) → split further into blank `templates/` + filled `example-switch24/`
- `screen-mode` skill → renamed `ideate-mode`, generalised off Switch24-specific relative paths
- Strata component sheet (`0.2_componentSheet/index.html`, `guide.html`) → `assets/strata-component-sheet/`
- 6 polished final-flow prototypes (product, basket, checkout, order-complete, setup-mobile, setup-insurance) → `example-switch24/prototypes/`

**Archived (stay in the source repos, not copied here):**
- The other ~38 output prototypes — ideation variants (12+ trust-bridge concepts, configurator ideation, QWEN basket tests, landing-page variants) — these are process artefacts of *how* the Switch24 example was reached, not part of what a new project needs. Full history remains in `0_designMDv3/0.1_designMDtesting/`.
- `kit/*.md` + `scripts/build-design-md.js` (the engine that assembles `design.md` from source) — maintainer-internal tooling, not designer-facing. Stays in `ao-figma-make-v2/`.
- The 5 exploratory test-project folders (`0.Switch24xMVNO`, `1.Breadboards`, `2.DealsPage`, `3.SolarPanels`, `4. Switch24xMVNO-MVP`) — superseded by the single curated `example-switch24/`.
- The original v3 "Kiro Power" spec (`ao-figma-make-v2/.kiro/specs/v3-kiro-power/`) — its rename/package/cleanup goals are what this v1.0.0 release actually completes; superseded by this changelog entry.

**Not carried forward:**
- `CHANGELOG.html` (stale duplicate of `.md`), `ao.com style.css.md` (duplicate of `ao_com-style.css`), `output/prototype-playground.zip`, committed `.DS_Store` files — none referenced by any retained file.

---

## Lineage (pre-v1.0.0 history)

This package's content descends from "AO Figma Make Kit," developed in `ao-figma-make-v2/` from 2026-05-15 through v2.6.0 (2026-06-21) — full dated entries for that period (typography cascade fixes, nav/header blueprint work, checkout-flow iterations, notice-component overhaul) are preserved unchanged in that repository's own `CHANGELOG.md`.

**2026-06-21 → 2026-07-09 (undocumented in the original changelog until now):** the project underwent its actual v3 transition — consolidating into a single 145 KB `design.md`, splitting steering into the six-file structure this package builds on, running the Switch24 signup flow through five ideation rounds (trust-bridge motion: rounds 1 through 3b, documented in full in `example-switch24/IDEATION.md`), and pushing multiple builds to Figma via the bridge workflow now captured as `example-switch24/FIGMA-BRIDGE.md`. This work happened but was never logged — this v1.0.0 entry is the first record of it.

**2026-07-25:** packaged as this standalone Kiro Power.
