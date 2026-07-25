# AOX-Prototyper

A Kiro Power for building AOX-compliant design-system prototypes and Figma builds — with an AI that pulls real tokens, real components, and real brand rules instead of guessing.

> **What it is:** An installable Kiro Power bundling locked design-system steering, per-project spec templates, a worked example (Switch24), and two workflow skills (Figma bridge, ideation), plus the `impeccable` frontend-craft skill.
> **What it isn't:** A component library. A dev handoff package on its own — it's the thing that makes AI-generated prototypes accurate enough that handoff is trivial.

---

## Quickstart

See [`POWER.md`](POWER.md) for the full onboarding steps, and [`docs/how-to-use.md`](docs/how-to-use.md) for a walkthrough. The short version:

1. Install this Power in Kiro (or point Claude Code at this folder — the `steering/`, `skills/`, and `templates/` files work the same way there).
2. Set `FIGMA_ACCESS_TOKEN` in your environment if you'll use the Figma bridge.
3. Start a new project: copy `templates/DISCOVERY.md`, `templates/PRODUCT.md`, `templates/DESIGN.md` into your project folder and fill them in.
4. Build. The AI reads `steering/design.md` for tokens/components, your filled templates for project context, and asks before leaving locked mode (`/ideate-mode`).

---

## Repository layout

```
POWER.md                    Kiro manifest — install this Power
mcp.json                    Figma MCP server config (figma-console)
README.md                   This file
CHANGELOG.md                Full version history

steering/                   LOCKED — always active once installed
  aox-design-system.md        Workspace rules + the four insights-derived protocols
  design.md                   AOX design system: tokens, typography, components, patterns, anti-patterns
  brand.md                    AOX brand guidelines: voice, colour, logo, graphic language

skills/                     Reusable workflows — install into .kiro/skills/
  figma-bridge/SKILL.md       Push an HTML prototype into Figma
  ideation/SKILL.md           Structured divergent/convergent design exploration
  ideate-mode/SKILL.md        Gate between locked design-system mode and exploratory mode

hooks/                      Install into .kiro/hooks/
  design-system-guard.kiro.hook   Flags hand-drawn SVGs / raw hex on save

templates/                  TO COMPLETE per project — copy into a new project folder
  DISCOVERY.md                 Research, evidence, hypotheses
  PRODUCT.md                   Users, purpose, commercial goals, anti-references
  DESIGN.md                    Locked project-specific design decisions

assets/
  strata-component-sheet/     The real, rendered Strata component markup — authoritative
                               over prose when a component's exact HTML/CSS is in question

example-switch24/            Worked example — a completed project, filled in
  DISCOVERY.md, PRODUCT.md, DESIGN.md    Filled templates
  IDEATION.md                            Full trust-bridge ideation history (rounds 1-3b)
  FIGMA-BRIDGE.md                        Real component/font/colour maps + push log
  prototypes/                            Polished final-flow screens only

docs/
  how-to-use.md               Full designer-facing walkthrough
```

---

## What you get

Every prototype built under this Power will:

- Use real AOX colour tokens — never raw hex
- Load SmileyFace and Inter correctly
- Render Strata icons from the real component sheet — never a hand-drawn substitute
- Apply `data-aods` attributes for dev handoff alignment
- Follow mobile-first layout with AOX's breakpoint scale
- Respect the component variant API — no invented states
- Stay in locked design-system mode unless you deliberately invoke `/ideate-mode`

---

## Relationship to AOX-DesignSystem

**AOX-Prototyper** is a Kiro Power component of the larger **AOX-DesignSystem** initiative, which coordinates design and dev alignment across projects. This Power is the shareable, stripped-down product of a longer internal experimentation process. The full experimentation history — dead-end prototypes, every ideation variant, the build tooling that assembles `design.md` from its source files — lives outside this package, in the maintainer's working repositories. This Power ships only what a new project needs to start.

---

**v1.0** · 2026-07-25 · AOX-DesignSystem
