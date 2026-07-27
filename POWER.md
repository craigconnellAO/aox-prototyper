---
name: "aox-prototyper"
displayName: "AOX-Prototyper"
description: "AOX design-system-strict prototyping kit: locked tokens/components/brand rules, guided project onboarding, per-project discovery/product/design templates, a worked Switch24 example, the Figma bridge and ideation workflows, and the impeccable frontend-craft skill."
keywords: ["aox", "ao.com", "design system", "strata", "design.md", "figma", "prototype", "switch24", "impeccable", "ideation", "steering", "onboarding"]
author: "AOX-DesignSystem"
---

# AOX-Prototyper

A shareable Kiro Power that packages the AOX design-system prototyping kit — the same rules, templates, and Figma workflow used to build Switch24 — for any designer or team to install and use on a new project.

## What this Power gives you

- **Locked steering** (`steering/`) — the AOX design system (`design.md`: tokens, typography, components, patterns, anti-patterns) and brand guidelines (`brand.md`). Always active once installed; this is what makes generated output token-accurate and brand-accurate instead of guessed.
- **Guided onboarding** (`steering/onboarding-flow.md`) — when your project's spec files are missing or unfilled, Kiro offers a five-batch conversational questionnaire and writes them for you. Self-gating: once they're filled, it never fires again.
- **Fillable project templates** (`templates/`) — `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`, each with a quick-fill *At a Glance* section on top and the deeper thinking sections below. Plus `STATUS.md` (live progress) and `QUICKSTART.md` (command reference).
- **A worked example** (`example-switch24/`) — the Switch24 MVNO signup flow, fully filled: real `DISCOVERY.md`/`PRODUCT.md`/`DESIGN.md`, a real `IDEATION.md` ideation history, a real `FIGMA-BRIDGE.md` push log, and the polished final-flow prototypes. Read this to see what a completed project looks like end to end.
- **Skills** (`skills/`) — `figma-bridge` (push an HTML prototype into Figma), `ideation` (structured divergent/convergent design exploration), and `ideate-mode` (the gate between locked and exploratory work — invoke `/ideate-mode` to deliberately leave the locked design system and explore).
- **A hook** (`hooks/`) — flags hand-drawn SVG icons and raw hex colours on save, instead of Strata icon-font classes and `design.md` tokens.
- **Figma MCP** (`mcp.json`) — the `figma-console` server, for the Figma bridge skill and direct Figma builds.

## Who it's for

AOX UX/product designers working with Kiro (or Claude Code, which reads the same `steering/`, `skills/`, and template files) who want AI-generated prototypes and Figma builds to be strict to the AOX design system on the first pass, not after several correction rounds.

## Prerequisites

- A Figma personal access token, set as the `FIGMA_ACCESS_TOKEN` environment variable before the Figma MCP will connect. Generate one from Figma → Settings → Security → Personal access tokens.
- The Figma Desktop Bridge plugin running in your target Figma file, if you intend to use the `figma-bridge` skill.

## What installing actually does

Kiro's Power installer copies **`POWER.md`, `steering/`, and `mcp.json`** into your environment. That's the whole automatic part, and it's enough for the Power's core promise: the design system is live, and onboarding will offer itself on your next session.

Everything else in this repo — `skills/`, `hooks/`, `templates/`, `assets/`, `example-switch24/` — is **not** copied by the installer. Kiro has no install-script mechanism, so those are a one-time manual copy if you want them:

```bash
cp -r skills/figma-bridge skills/ideation skills/ideate-mode <your-workspace>/.kiro/skills/
cp hooks/design-system-guard.kiro.hook <your-workspace>/.kiro/hooks/
```

You don't need to copy `templates/`. If your spec files are missing, onboarding writes them from scratch.

Full walkthrough: `docs/how-to-use.md`.

## The onboarding flow

When you start a session and `DISCOVERY.md` / `PRODUCT.md` / `DESIGN.md` are missing or still carry the unfilled marker, Kiro opens with:

> "Before we start — I can see this project's spec files aren't filled in yet. Want me to run a quick onboarding questionnaire to populate them?"

Say yes and it walks you through five batches:

| Batch | Covers | Populates |
|---|---|---|
| 1. Discovery | Project name, owner, problem, users, constraints | `DISCOVERY.md` |
| 2. Product | User stories, flows, screens, out of scope | `PRODUCT.md` |
| 3. Design | Layout, components, locked decisions, a11y target | `DESIGN.md` |
| 4. Tools | Figma token, impeccable install | `STATUS.md` |
| 5. References | Figma links, competitor and inspiration refs | `DESIGN.md` |

About two minutes. Say "skip onboarding" at any point — including mid-flow — and it writes what's been gathered so far and leaves the rest to you.

Once complete: the templates lose their markers (so onboarding won't trigger again), `STATUS.md` is created with setup items checked off, and `QUICKSTART.md` opens as your command reference.

## Live progress tracking

`STATUS.md` is maintained by Kiro as you work — no hook, no script:

| What you do | What gets checked off |
|---|---|
| Complete onboarding | Project templates filled in |
| Copy the skills / guard hook in | Skills copied / hook copied |
| Save an HTML prototype | Built first screen prototype |
| Prototype passes a compliance pass | Uses tokens, Strata icons, `data-aods` |
| Use figma-bridge | Pushed a prototype to Figma |
| Use ideation | Ran ideation session |
| Invoke `/ideate-mode` | Entered ideate-mode |
| Add a row to DESIGN.md → Locked Decisions | Locked a design decision |

Check items yourself any time — Kiro won't overwrite a box you've set by hand. Or just ask: "update STATUS.md".

## After onboarding

You're ready to prototype. Ask Kiro to:

- **Build a screen** — "build the delivery options screen from my product flow"
- **Explore directions** — use the `ideation` skill to generate multiple options
- **Push to Figma** — use the `figma-bridge` skill
- **Leave the system** — invoke `/ideate-mode` to deliberately explore outside the locked design system
- **Check progress** — open `STATUS.md`

## File structure

```
POWER.md                       ← you are here (installed automatically)
README.md
CHANGELOG.md
mcp.json                       ← Figma MCP config (installed automatically)

steering/                      ← installed automatically; always active
  aox-design-system.md           workspace rules + the four insights-derived protocols
  design.md                      tokens, typography, components, patterns, anti-patterns
  brand.md                       AO brand guidelines
  onboarding-flow.md             guided project setup (self-gating)

skills/                        ← manual copy → .kiro/skills/
  figma-bridge/SKILL.md
  ideation/SKILL.md
  ideate-mode/SKILL.md

hooks/                         ← manual copy → .kiro/hooks/
  design-system-guard.kiro.hook

templates/                     ← reference copies; onboarding can write these for you
  DISCOVERY.md  PRODUCT.md  DESIGN.md
  STATUS.md     QUICKSTART.md
  IMPECCABLE.md                  written only when impeccable is installed

assets/
  strata-component-sheet/        authoritative rendered Strata markup

example-switch24/              ← worked example, filled in end to end
docs/how-to-use.md
```

## When to load steering

- **Always:** `steering/aox-design-system.md`, `steering/design.md`, `steering/brand.md`, `steering/onboarding-flow.md` (dormant unless spec files are unfilled)
- Building or editing any prototype screen → `steering/aox-design-system.md` §Protocols (resolve-before-build, verify-or-flag)
- Pushing a prototype to Figma → `skills/figma-bridge/SKILL.md` and the project's own `FIGMA-BRIDGE.md`
- Exploring multiple directions for a screen/flow → `skills/ideation/SKILL.md`, gated by `skills/ideate-mode/SKILL.md`

## Confirming the Power is active

Ask "what colour token would I use for a primary CTA?" — a correctly-installed Power answers from `design.md` (`--action-primary-base`), not a guessed hex value.
