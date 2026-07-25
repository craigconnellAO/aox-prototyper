---
name: "aox-prototyper"
displayName: "AOX-Prototyper"
description: "AOX design-system-strict prototyping kit: locked tokens/components/brand rules, per-project discovery/product/design templates, a worked Switch24 example, the Figma bridge and ideation workflows, and the impeccable frontend-craft skill."
keywords: ["aox", "ao.com", "design system", "strata", "design.md", "figma", "prototype", "switch24", "impeccable", "ideation", "steering"]
author: "AOX-DesignSystem"
---

# AOX-Prototyper

A shareable Kiro Power that packages the AOX design-system prototyping kit — the same rules, templates, and Figma workflow used to build Switch24 — for any designer or team to install and use on a new project.

## What this Power gives you

- **Locked steering** (`steering/`) — the AOX design system (`design.md`: tokens, typography, components, patterns, anti-patterns) and brand guidelines (`brand.md`). Always active once installed; this is what makes generated output token-accurate and brand-accurate instead of guessed.
- **Fillable project templates** (`templates/`) — `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`. Copy these into a new project folder at the start of a spec and fill them in; they're what the skills and `impeccable` read for project-specific context.
- **A worked example** (`example-switch24/`) — the Switch24 MVNO signup flow, fully filled: real `DISCOVERY.md`/`PRODUCT.md`/`DESIGN.md`, a real `IDEATION.md` ideation history, a real `FIGMA-BRIDGE.md` push log, and the polished final-flow prototypes. Read this to see what a completed project looks like end to end.
- **Skills** (`skills/`) — `figma-bridge` (push an HTML prototype into Figma), `ideation` (structured divergent/convergent design exploration), and `ideate-mode` (the gate between locked and exploratory work — invoke `/ideate-mode` to deliberately leave the locked design system and explore).
- **A hook** (`hooks/`) — flags hand-drawn SVG icons and raw hex colours on save, instead of Strata icon-font classes and `design.md` tokens.
- **Figma MCP** (`mcp.json`) — the `figma-console` server, for the Figma bridge skill and direct Figma builds.

## Who it's for

AOX UX/product designers working with Kiro (or Claude Code, which reads the same `steering/`, `skills/`, and template files) who want AI-generated prototypes and Figma builds to be strict to the AOX design system on the first pass, not after several correction rounds.

## Prerequisites

- A Figma personal access token, set as the `FIGMA_ACCESS_TOKEN` environment variable before the Figma MCP will connect. Generate one from Figma → Settings → Security → Personal access tokens.
- The Figma Desktop Bridge plugin running in your target Figma file, if you intend to use the `figma-bridge` skill.

## Onboarding steps

Follow these once, when you first install this Power:

1. **Confirm the steering is active.** Ask Kiro "what design system am I working under?" — it should describe the AOX token/component rules from `steering/aox-design-system.md`. If it doesn't, the Power isn't installed correctly.
2. **Install the skills into your workspace.** Copy `skills/figma-bridge/`, `skills/ideation/`, and `skills/ideate-mode/` into your workspace's `.kiro/skills/`.
3. **Install the hook.** Copy `hooks/design-system-guard.kiro.hook` into your workspace's `.kiro/hooks/`.
4. **Install impeccable**, the frontend-craft skill this Power's `ideate-mode` and templates are designed to work alongside: run `npx impeccable` in your workspace (see [impeccable's own docs] for the current install command) — it reads a project's `PRODUCT.md`/`DESIGN.md` automatically once you've copied the templates in (step 5).
5. **Start a new project.** Copy the three files from `templates/` into your project folder, rename none of them (`DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md` — these exact names are what `impeccable` and `ideate-mode` look for), and fill them in. Use `example-switch24/` as a reference for what "filled in" looks like.
6. **Set `FIGMA_ACCESS_TOKEN`** in your environment before using the `figma-bridge` skill or any direct Figma MCP call.

Full walkthrough: `docs/how-to-use.md`.

## When to load steering

- Always: `steering/aox-design-system.md`, `steering/design.md`, `steering/brand.md` — these are `inclusion: always`.
- Building or editing any prototype screen → `steering/aox-design-system.md` §Protocols (resolve-before-build, verify-or-flag)
- Pushing a prototype to Figma → `skills/figma-bridge/SKILL.md` and the project's own `FIGMA-BRIDGE.md`
- Exploring multiple directions for a screen/flow → `skills/ideation/SKILL.md`, gated by `skills/ideate-mode/SKILL.md`

## Confirming the Power is active

Ask "what colour token would I use for a primary CTA?" — a correctly-installed Power answers from `design.md` (`--action-primary-base`), not a guessed hex value.
