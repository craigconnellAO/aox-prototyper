# Changelog

## v1.2.1 — 2026-07-29

**Onboarding now writes `FIGMA-BRIDGE.md`, removing the last manual-copy step for spec files.**

### What changed

- **`steering/onboarding-flow.md`** — Batch 4 now writes `FIGMA-BRIDGE.md` in the same final pass as `DISCOVERY.md` / `PRODUCT.md` / `DESIGN.md` / `STATUS.md` / `QUICKSTART.md`, regardless of whether the user has a Figma token yet. The working-file row is left as its placeholder (`[Project File Name]` / `[file_key]`) until they have a real file to push to; the Design System 2025 library row is a fixed AOX default and gets written in immediately. The closing recap message now mentions it.
- **`POWER.md`** — removed the "copy `FIGMA-BRIDGE.md` before your first push" instruction. Updated the onboarding batch table, file-structure diagram, and `STATUS.md` progress table to reflect that onboarding writes the file; the remaining manual step is filling in the *target file*, not copying the template.
- **`README.md`** — Quickstart steps 4 and 6 updated: step 4 now lists `FIGMA-BRIDGE.md` among the files onboarding writes; step 6 no longer says "copy the template in."
- **`templates/STATUS.md`** — checklist item changed from *"`FIGMA-BRIDGE.md` copied in from `templates/` and target file filled in"* to *"`FIGMA-BRIDGE.md` target Figma file filled in (the file itself was written during onboarding)"*.
- **`docs/how-to-use.md`** §8 — rewritten to match: `FIGMA-BRIDGE.md` is already present from onboarding, so the walkthrough starts at filling in the target file. A one-line fallback covers the by-hand setup path (§6), where the template still needs a manual copy since there's no onboarding pass to write it.

### Why this matters

There was never a technical reason `FIGMA-BRIDGE.md` needed manual copying while the other four spec files didn't. The installer-copy limitation that makes `skills/` and `hooks/` manual (Kiro's Power installer only copies `POWER.md`, `steering/`, and `mcp.json`) doesn't apply to files onboarding writes itself — it was already generating `DISCOVERY.md` through `QUICKSTART.md` from templates or from scratch, in the same pass, for a workspace with no `templates/` folder at all. `FIGMA-BRIDGE.md` was the one exception, for no reason tied to how it's installed or delivered. It's now consistent with the rest.

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

### Branch reconciliation

The v1.1.0 work (guided onboarding, `STATUS.md`, `QUICKSTART.md`, `IMPECCABLE.md`) had been committed on a local branch and never pushed, while v1.2.0's Figma fix went straight to `main`. The two lines are merged here. Both feature sets are intact; no file additions collided, and `POWER.md` / `docs/how-to-use.md` / `README.md` were reconciled by hand.

Follow-on fixes made during the merge:

- `templates/FIGMA-BRIDGE.md` is now surfaced everywhere it should be — `POWER.md`'s install note and file structure, `STATUS.md`'s checklist, and the `onboarding-flow.md` status table. It's the one template that still needs a manual copy, because onboarding doesn't write it.
- Remaining `steering/ao-design-system.md` pointers (pre-rebrand path) corrected to `aox-design-system.md` in `docs/how-to-use.md` and the v1.0.0 changelog entry.
- Remaining "AO designMD" product references renamed to **AOX-Prototyper**. External repo and Figma page names (`0_designMDv3`, the `designMD v3` page in the Switch24 push log) are left alone — they're real names of things outside this package.
- `README.md` corrected: it claimed two skills where there are three, implied `impeccable` ships bundled when it doesn't, and omitted `steering/figma-library.md` and `templates/FIGMA-BRIDGE.md` from the layout. Quickstart now covers copying the skills in and the Figma push path, both of which were missing. Copy tightened throughout.

---

## v1.1.0 — 2026-07-27

Guided onboarding, live progress tracking, and a quick-start reference — folded in from a clean-room test of the Power (`PrototyperTest_1`), where a new-user run built an AO Solar lead-gen landing page from scratch and surfaced where the setup path was too manual.

### Guided onboarding

New `steering/onboarding-flow.md`: a five-batch conversational questionnaire (discovery → product → design → tools → references) that populates a project's spec files instead of leaving the user to copy templates and fill them from an example. Roughly two minutes, skippable at any point including mid-flow.

It lives in `steering/` rather than behind a `SessionStart` hook, and it's **self-gating** — the file opens with a condition check and stays dormant once `DISCOVERY.md`, `PRODUCT.md`, and `DESIGN.md` exist without the unfilled marker. See "Why no scripts" below.

### Live progress tracking

New `templates/STATUS.md` — a setup/first-prototype/exploration/ongoing checklist that Kiro keeps current as milestones land. Agent-maintained by an instruction table in `onboarding-flow.md`; it re-reads before writing, so a box you tick by hand stays ticked.

### Quick-start reference

New `templates/QUICKSTART.md` — build commands, the three skills, a design-system-at-a-glance table, and what each project file is for. Written after onboarding as the user's first reference point.

Its design-system values were verified against `steering/design.md` rather than restated from memory: the spacing scale runs to 56 and 64 (an earlier draft stopped at 48), 14px is the SmileyFace floor (`text-title-sm`), and the radius set is xs:4 / sm:8 / md:16 / xl:24 / 2xl:40.

### Templates — quick-fill on top, thinking underneath

`DISCOVERY.md`, `PRODUCT.md`, and `DESIGN.md` each gain an **At a Glance** section: the minimum context needed to generate a correct screen, in a form onboarding can populate directly. Everything already in these templates is retained beneath it — research themes, falsifiable hypotheses, brand personality, *What [Product] Is Not*, the §7a exception protocol, colour strategy, motion, tone.

The test run had replaced these wholesale with short tabular stubs. That reads as an improvement for auto-fill and a real loss as a thinking tool, and it desynchronised the templates from `example-switch24/`. Merged rather than swapped, so both properties hold.

`PRODUCT.md` also gains genuinely new sections that had no equivalent: **User Stories**, **Flows**, **Screens**, **Edge Cases & Error States**, **Out of Scope**, **Dependencies**. `DESIGN.md` gains a **Locked Decisions** register (decision / reason / date — so the *why* survives the six-week-later question) and an **Open Questions** table that deliberately holds pointers only, resolved in `IDEATION.md` rather than answered inline. Answering them inline is the exact failure `/ideate-mode` exists to prevent.

### Why no scripts

The test run also produced three JSON hooks and three shell scripts. None shipped. The reason is worth recording, because it constrains anything similar in future:

**Kiro's Power installer copies `POWER.md`, `steering/`, and `mcp.json`, and nothing else.** Verified across all five powers installed locally — `hooks/`, `skills/`, `templates/`, and `scripts/` never reach `~/.kiro/powers/installed/`. There is no install-lifecycle hook. A `scaffold.sh` shipped in the repo is therefore unreachable from where the Power actually runs.

That makes `steering/` the only surface a Power can rely on, which is why onboarding is prose in `steering/` and `STATUS.md` is agent-maintained. The features survived; their delivery mechanism didn't.

The scripts were also individually unsound, and none had ever executed — the test workspace's `.kiro/` contained only `settings/mcp.json`. `grep -P` doesn't exist on stock macOS (`/usr/bin/grep` exits 2), so `update-status.sh`'s `! grep -qP` guard-check inverted to *true* and would have falsely reported design-system compliance. `sed -i ''` is BSD-only. All three hooks hardcoded a `${WORKSPACE_FOLDER}/power/scripts/` path that only existed in the test project's layout.

### design-system-guard — kept as-is

`hooks/design-system-guard.kiro.hook` is unchanged. The test run's replacement (`design-system-guard.json`) was not adopted: it greps for raw hex and exits 2, but every compliant prototype embeds the `:root` token block, where hex values are *defined* — 74 matches in `example-switch24/prototypes/basket.html`, 35 in the test's own output. It would have blocked on the Power's own worked example. Its emoji character class also contained a literal `+`, matching any plus sign in the file.

More to the point, the regex version dropped hand-drawn-`<svg>` detection — Protocol 1, and the largest single friction category in the v1.0.0 `/insights` review. The `askAgent` hook catches it; a regex can't.

### Impeccable — reference card and a collision warning

New `templates/IMPECCABLE.md`, written into a project only when impeccable is actually installed. Onboarding now checks for an existing install (`~/.kiro/skills/impeccable/`) before offering to run `npx impeccable`, rather than offering to install something the user already has.

The card groups all 23 commands by intent, generated from the installed skill's `scripts/command-metadata.json` rather than recalled. The grouping that matters is **Expression** — `bolder`, `colorize`, `delight`, `animate`, `overdrive` deliberately push away from a locked design system, so they belong behind `/ideate-mode` or their output leaks into a locked `DESIGN.md`. (`quieter` is the exception; it usually moves toward compliance.)

It also documents a filename collision that was previously undocumented: `/impeccable init` and `/impeccable document` write `PRODUCT.md` and `DESIGN.md` — the same names this Power uses. Impeccable never overwrites silently and always asks first, so nothing is lost by accident, but its `DESIGN.md` follows the Google Stitch spec (YAML token frontmatter, six fixed non-renameable sections) and is not compatible with the AOX one. Its `PRODUCT.md` is near-identical to the AOX section list — target users, purpose, brand personality, anti-references, design principles — and is safe to let it extend with `## Register` / `## Platform`.

`docs/how-to-use.md` §4 previously described impeccable as reading `PRODUCT.md` and `DESIGN.md`. It writes them too; corrected.

### Tool boundaries and the promotion route

Two new sections in `steering/aox-design-system.md`, both always-active.

**Tool Boundaries** splits the world into a system tier (`design.md`, `brand.md`, `aox-design-system.md` — org-wide) and a project tier (the spec files, `IDEATION.md`, `STATUS.md`, prototypes). Companion tools, impeccable especially, operate on the project tier only.

In normal use that's structural rather than disciplinary: an installed Power's `steering/` sits outside the workspace, so a project-level tool cannot reach it. The rule exists for the one case where it can — **when the workspace is the power repo itself**, where `steering/` is an ordinary editable file. There, system-tier files are read-only unless the user has explicitly asked to change the design system.

**Promoting a Project Decision into the System** formalises something that had happened once but was never written down. `--switch-purple` went from prototype use → flagged as a conflict → adopted into `design.md` §7a with an explicit scope. That path is now a documented six-step route: keep it local until proven, state the case, check it isn't already solvable with an existing blueprint, get a human decision, write it into the right home *with scope*, record it.

Step 4 is the load-bearing one — promotion happens because a person asked, never because a tool suggested it or an audit flagged it. And an exception that can't name the surfaces it applies to isn't ready: that's the difference between a sanctioned exception and the palette quietly getting wider.

### Docs

`POWER.md` gains the onboarding and progress-tracking sections, an accurate file-structure diagram, and an install section that states plainly what the installer does and does not copy. `docs/how-to-use.md` §1 documents the three-item install so it's checkable, §3 marks the guard hook optional, and §6 covers both the guided and by-hand setup paths. `README.md` quickstart and layout updated to match. The stale product title in `how-to-use.md` is now "AOX-Prototyper".

---

## v1.0.0 — 2026-07-25

First release of **AOX-Prototyper**, a standalone shareable Kiro Power. This is a new package assembled from roughly three months of internal experimentation (originally "AO Figma Make Kit") — not a continuation of that repo's version numbers. See **Lineage** below for how it got here.

### Package structure

Reorganised around three tiers, reflecting how the content actually gets used:

- **Locked steering** (`steering/`) — org-wide, rarely changes: `design.md` (tokens/typography/components/patterns/anti-patterns), `brand.md` (AO brand guidelines), and a new `aox-design-system.md` workspace-rules file.
- **Project templates** (`templates/`) — `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`, blank, to be filled in at the start of each new project's spec.
- **Skills** (`skills/`) — reusable workflows, each a proper Kiro `SKILL.md`: `figma-bridge`, `ideation`, and `ideate-mode`.

Plus a worked example (`example-switch24/`) — the filled Switch24 project, kept as the proof the system works end to end — and a Figma MCP config (`mcp.json`).

### `/insights` findings folded in

A Claude Code `/insights` review of this workspace's session history (2026-05-02 to 2026-07-19, 35 sessions) surfaced four recurring friction patterns. Each is now an explicit, named protocol in `steering/aox-design-system.md`, rather than left as tacit knowledge:

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
