# Changelog

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

### Docs

`POWER.md` gains the onboarding and progress-tracking sections, an accurate file-structure diagram, and an install section that states plainly what the installer does and does not copy. `docs/how-to-use.md` §1 documents the three-item install so it's checkable, §3 marks the guard hook optional, and §6 covers both the guided and by-hand setup paths. `README.md` quickstart and layout updated to match. The stale "AO designMD" title in `how-to-use.md` is now "AOX-Prototyper".

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
