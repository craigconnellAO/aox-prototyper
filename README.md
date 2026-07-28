# AOX-Prototyper

A Kiro Power for AOX-compliant prototypes and Figma builds — Kiro reads your actual design tokens, components, and brand rules instead of guessing at them.

> **What it is:** An installable Kiro Power bundling locked design-system steering, guided project onboarding, per-project spec templates, a worked example (Switch24), and three workflow skills — `figma-bridge`, `ideation`, and `ideate-mode`.
> **What it isn't:** A component library, or a handoff package. It's what makes the prototypes accurate enough that handoff stops being a translation exercise.

---

## Quickstart

See [`POWER.md`](POWER.md) for the full onboarding steps, and [`docs/how-to-use.md`](docs/how-to-use.md) for a walkthrough. The short version:

1. **Install this Power in Kiro.** The installer copies `POWER.md`, `steering/`, and `mcp.json` — and nothing else. Skills and the guard hook are a one-time manual copy (see [`POWER.md`](POWER.md)). Using Claude Code instead? No install step; just open this folder.
2. **Copy the skills in.** `cp -r skills/* <your-workspace>/.kiro/skills/` — this is the step people miss, and without it `/ideate-mode` and the Figma bridge aren't available.
3. **Set `FIGMA_ACCESS_TOKEN`** in your environment if you'll push to Figma.
4. **Start a session in your project folder.** Kiro sees the spec files aren't there and offers a two-minute onboarding questionnaire that writes `DISCOVERY.md`, `PRODUCT.md`, and `DESIGN.md` for you — or copy them from `templates/` and fill them in by hand.
5. **Build.** Ask for a screen; Kiro pulls tokens and components from the design system automatically.
6. **Push to Figma (optional).** Copy `templates/FIGMA-BRIDGE.md` into your project, fill in your target file, then run the `figma-bridge` skill.

---

## Repository layout

```
POWER.md                    Kiro manifest, installed automatically
mcp.json                    Figma MCP server config (figma-console), installed automatically
README.md                   this file
CHANGELOG.md                version history

steering/                   installed automatically, always active
  aox-design-system.md        workspace rules and the four insights-derived protocols
  design.md                   tokens, typography, components, patterns, anti-patterns
  brand.md                    AOX brand guidelines: voice, colour, logo, graphic language
  figma-library.md            Figma component keys, icon mappings, font names, known gaps
  onboarding-flow.md          guided project setup, dormant once the spec files are filled

skills/                     manual copy into .kiro/skills/
  figma-bridge/SKILL.md       pushes an HTML prototype into Figma
  ideation/SKILL.md           structured divergent/convergent design exploration
  ideate-mode/SKILL.md        the gate between locked and exploratory mode

hooks/                      manual copy into .kiro/hooks/
  design-system-guard.kiro.hook   flags hand-drawn SVGs and raw hex on save

templates/                  per-project files; onboarding writes these, or copy them yourself
  DISCOVERY.md                research, evidence, hypotheses
  PRODUCT.md                  users, flows, screens, purpose, commercial goals, anti-references
  DESIGN.md                   locked project-specific design decisions
  FIGMA-BRIDGE.md             per-project Figma target file, mappings, and push log
  STATUS.md                   live progress checklist, maintained by Kiro
  QUICKSTART.md               command and design-system reference card
  IMPECCABLE.md               impeccable command reference, written only if impeccable is installed

assets/
  strata-component-sheet/     the rendered Strata markup, authoritative over prose
                              when a component's exact HTML/CSS is in question

example-switch24/           a completed project, filled in end to end
  DISCOVERY.md, PRODUCT.md, DESIGN.md    filled spec files
  IDEATION.md                            trust-bridge ideation history (rounds 1-3b)
  FIGMA-BRIDGE.md                        a real push log with component and font maps
  prototypes/                            the polished final-flow screens

docs/
  how-to-use.md               full designer-facing walkthrough
```

---

## What you get

Every prototype built under this Power will:

- Use real AOX colour tokens — never raw hex
- Load SmileyFace and Inter correctly
- Render Strata icons from the real component sheet — never a hand-drawn substitute
- Tag every component with `data-aods`, so engineers can map it straight to the React component
- Follow mobile-first layout with AOX's breakpoint scale
- Respect the component variant API — no invented states
- Stay in locked design-system mode unless you deliberately invoke `/ideate-mode`

---

## Working alongside impeccable

`impeccable` is a separate frontend-craft skill this Power's templates and `ideate-mode` are built to work with. It isn't bundled — install it yourself (`npx impeccable`) so you always get the current version. See [`docs/how-to-use.md`](docs/how-to-use.md) §4 for the one collision worth knowing about before you run `/impeccable init`.

---

## Relationship to AOX-DesignSystem

AOX-Prototyper is part of the broader **AOX-DesignSystem** initiative, which coordinates design and dev alignment across projects. This package is the shareable subset — only what a new project needs to start. The full experimentation history stays in the maintainer's working repos.

---

**v1.2** · 2026-07-28 · AOX-DesignSystem
