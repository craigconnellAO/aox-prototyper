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
- **Fillable project templates** (`templates/`) — `DISCOVERY.md`, `PRODUCT.md`, `DESIGN.md`, each with a quick-fill *At a Glance* section on top and the deeper thinking sections below. Plus `STATUS.md` (live progress), `QUICKSTART.md` (command reference), and `FIGMA-BRIDGE.md` (per-project Figma push record). Onboarding writes all of these for you.
- **A worked example** (`example-switch24/`) — the Switch24 MVNO signup flow, fully filled: real `DISCOVERY.md`/`PRODUCT.md`/`DESIGN.md`, a real `IDEATION.md` ideation history, a real `FIGMA-BRIDGE.md` push log, and the polished final-flow prototypes. Read this to see what a completed project looks like end to end.
- **Skills** (`skills/`) — `figma-bridge` (push an HTML prototype into Figma), `ideation` (structured divergent/convergent design exploration), `ideate-mode` (the gate between locked and exploratory work — invoke `/ideate-mode` to deliberately leave the locked design system and explore), and `design-review` (the compliance pass over finished work, `/design-review`).
- **Two hooks** (`hooks/`) — a **scan** that runs a shell script on every HTML save (free, milliseconds, no agent turn) flagging raw hex and inline `<svg>`, and a **review** you trigger by hand when a screen or flow is finished, which judges those findings and adds the checks a grep can't make. The expensive half only runs when you ask for it.
- **An installer** (`scripts/install-aox-power.sh`) — copies the skills, hooks, scan script and component sheet into your workspace, because Kiro's Power installer doesn't. Onboarding offers to run it; you can also run it yourself any time.
- **Figma steering** (`steering/figma-library.md`) — component keys, icon mappings, font gotchas, and known gaps for DS 2025, shared by all projects using this Power.
- **Figma MCP** (`mcp.json`) — the `figma-console` server, for the Figma bridge skill and direct Figma builds.

## Who it's for

AOX UX/product designers working with Kiro (or Claude Code, which reads the same `steering/`, `skills/`, and template files) who want AI-generated prototypes and Figma builds to be strict to the AOX design system on the first pass, not after several correction rounds.

## Prerequisites

- A Figma personal access token, set as the `FIGMA_ACCESS_TOKEN` environment variable before the Figma MCP will connect. Generate one from Figma → Settings → Security → Personal access tokens.
- The Figma Desktop Bridge plugin running in your target Figma file, if you intend to use the `figma-bridge` skill.

## What installing actually does

Kiro's Power installer copies **`POWER.md`, `steering/`, and `mcp.json`** into your environment. That's the whole automatic part, and it's enough for the Power's core promise: the design system is live, and onboarding will offer itself on your next session.

Everything else in this repo — `skills/`, `hooks/`, `scripts/`, `assets/`, `templates/`, `example-switch24/` — is **not** copied by the installer, and Kiro has no install-script mechanism inside a Power to do it for you.

So the Power ships its own installer. Run it once, from your workspace root:

```bash
bash ~/.kiro/powers/repos/aox-prototyper/scripts/install-aox-power.sh
```

Or just ask Kiro — *"install the AOX skills and hooks"* — and it'll find the repo and run it for you. **Onboarding also offers this in Batch 4**, so on a fresh project you can simply say yes.

It copies four things: the skills into `.kiro/skills/`, the hooks into `.kiro/hooks/`, the scan script into `.kiro/scripts/`, and the Strata component sheet into `assets/` — the last one matters, because Protocol 1 tells Kiro to read `assets/strata-component-sheet/index.html` before writing any screen, and until it's there that instruction points at nothing.

It's idempotent, backs up anything it would overwrite, and takes `--dry-run`, `--only skills,hooks`, `--target <dir>`, `--agent claude`, and `--uninstall`. On Windows without Git Bash, ask Kiro to make the copies with its file tools instead — `steering/onboarding-flow.md` has the source→destination table.

You don't need to copy `templates/` — if `DISCOVERY.md` / `PRODUCT.md` / `DESIGN.md` / `FIGMA-BRIDGE.md` are missing, onboarding writes them all from scratch, in the same pass. `FIGMA-BRIDGE.md` gets written with a placeholder target file even if you don't have a Figma token yet; fill in the real file once you're ready to push.

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
| 4. Tools | Figma token, skills/hooks install, impeccable install | `STATUS.md`, `FIGMA-BRIDGE.md`, `.kiro/` |
| 5. References | Figma links, competitor and inspiration refs | `DESIGN.md` |

About two minutes. Say "skip onboarding" at any point — including mid-flow — and it writes what's been gathered so far and leaves the rest to you.

Once complete: the templates lose their markers (so onboarding won't trigger again), `STATUS.md` is created with setup items checked off, `FIGMA-BRIDGE.md` is written with a placeholder target file ready for your first push, and `QUICKSTART.md` opens as your command reference.

## The design-system guard: free on save, paid on demand

Two hooks, split along the line between what a grep can decide and what needs judgement.

| | **Design System Scan** | **Design System Review** |
|---|---|---|
| Fires | Every `.html` save | When you click it |
| Runs | `.kiro/scripts/ds-scan.sh` | An agent turn |
| Costs | Nothing, ~50ms | Credits and time |
| Finds | Raw hex outside `:root`, inline `<svg>` | Which of those are real, plus header variant, typography, spacing scale, `data-aods` coverage |
| Output | `.kiro/ds-guard-report.md` | A grouped report; it never edits your files |

The scan is deliberately dumb: it flags candidates and writes them down. The review reads that report instead of re-deriving it, so the expensive pass starts with the mechanical work already done — and it only happens when a screen or flow is actually finished, which is when a review is worth paying for. Kiro will offer it at those moments; you can also run it yourself from the Agent Hooks panel.

A legitimate `<svg>` — a brand logo, a sprite sheet, an illustration — stops being reported once you mark it:

```html
<svg data-ds-allow="brand logo" viewBox="0 0 132 34">…</svg>
```

The review also ships as a skill — **`/design-review`** — running the same pass. Use it when hooks aren't installed, when your Kiro uses the newer PascalCase hook format (which has no manual trigger), or in Claude Code, where `.kiro.hook` files don't apply. See `docs/how-to-use.md` §3.

A third hook, **Design System Review (automatic)**, ships **disabled**. It runs the review once per agent turn rather than on demand, and exits without spending anything when the scan is clean. Enable it in `.kiro/hooks/design-system-review-on-stop.kiro.hook` if you'd rather not remember to click — but the manual one is the default for a reason.

> **Upgrading from v1.2 or earlier:** the old `design-system-guard.kiro.hook` fired a full agent review on *every* HTML save, including every save Kiro itself made mid-build. That's what this replaces. The installer retires it automatically; if you copied it in by hand, delete it.

## Live progress tracking

`STATUS.md` is maintained by Kiro as you work — no hook, no script:

| What you do | What gets checked off |
|---|---|
| Complete onboarding | Project templates filled in |
| Run `install-aox-power.sh` | Skills / hooks / component sheet copied |
| Save an HTML prototype | Built first screen prototype |
| Run a Design System Review | Ran a design-system review |
| Prototype passes a compliance pass | Uses tokens, Strata icons, `data-aods` |
| Fill in your real target file in `FIGMA-BRIDGE.md` | `FIGMA-BRIDGE.md` target file filled in |
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
  figma-library.md               Figma component keys, icon maps, font names, known gaps
  onboarding-flow.md             guided project setup (self-gating)

scripts/                       ← run install-aox-power.sh; it copies the four blocks below
  install-aox-power.sh           skills + hooks + scan script + component sheet → your workspace
  ds-scan.sh                     the free save-time scan → .kiro/scripts/

skills/                        ← installed by the script → .kiro/skills/
  figma-bridge/SKILL.md
  ideation/SKILL.md
  ideate-mode/SKILL.md
  design-review/SKILL.md         the review pass, also available as a hook

hooks/                         ← installed by the script → .kiro/hooks/
  design-system-scan.kiro.hook             on save · shell script · free
  design-system-review.kiro.hook           on demand · agent · the paid one
  design-system-review-on-stop.kiro.hook   per turn · agent · ships disabled

templates/                     ← reference copies; onboarding writes all of these for you
  DISCOVERY.md  PRODUCT.md  DESIGN.md
  STATUS.md     QUICKSTART.md
  FIGMA-BRIDGE.md                written with a placeholder target file, filled in before your first push
  IMPECCABLE.md                  written only when impeccable is installed

assets/                        ← installed by the script → your workspace root
  strata-component-sheet/        authoritative rendered Strata markup; Protocol 1 reads this

example-switch24/              ← worked example, filled in end to end
docs/how-to-use.md
```

## When to load steering

- **Always:** `steering/aox-design-system.md`, `steering/design.md`, `steering/brand.md`, `steering/onboarding-flow.md` (dormant unless spec files are unfilled)
- Building or editing any prototype screen → `steering/aox-design-system.md` §Protocols (resolve-before-build, verify-or-flag)
- Pushing a prototype to Figma → `steering/figma-library.md` (component keys, icon mappings, fonts, known gaps), then `skills/figma-bridge/SKILL.md` (method), then the project's own `FIGMA-BRIDGE.md` (working record)
- Exploring multiple directions for a screen/flow → `skills/ideation/SKILL.md`, gated by `skills/ideate-mode/SKILL.md`

## Confirming the Power is active

Ask "what colour token would I use for a primary CTA?" — a correctly-installed Power answers from `design.md` (`--action-primary-base`), not a guessed hex value.
