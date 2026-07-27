# AOX-Prototyper — Quick Start

You're set up and ready to go. Here's what you can do.

---

## Build a Prototype

Just ask. Kiro generates AOX-compliant HTML with correct tokens, typography, and components.

```
"Build the delivery options screen"
"Create a sign-in page"
"Prototype the order confirmation flow"
```

Every output follows the locked design system — real tokens, the Strata icon font, `data-aods` attributes for dev handoff, mobile-first layout.

---

## Skills

These need copying into `.kiro/skills/` once — see `docs/how-to-use.md`.

| Skill | What it does | How to use |
|---|---|---|
| **figma-bridge** | Push an HTML prototype into your Figma file | "Push this prototype to Figma" |
| **ideation** | Generate multiple design directions for a screen | "Explore 3 directions for the checkout layout" |
| **ideate-mode** | Temporarily leave the locked system to experiment | "/ideate-mode" |

---

## Key Commands

| Command | What happens |
|---|---|
| "Build [screen name]" | Generates a full AOX-compliant HTML prototype |
| "Push to Figma" | Sends the current prototype to your Figma file |
| "Explore directions for [screen]" | Runs structured ideation (3+ options) |
| "/ideate-mode" | Unlocks exploratory mode (leaves the design system) |
| "Check my design system compliance" | Audits the current file against AOX rules |
| "What token for [intent]?" | Returns the correct design token |
| "Update STATUS.md" | Refreshes the live checklist |

---

## Design System at a Glance

| Element | Rule |
|---|---|
| **Primary CTA** | `--action-primary-base` — one per section |
| **Headings** | SmileyFace Bold — never below 14px (`text-title-sm` is the floor) |
| **Body text** | Inter 400 — line-height 1.625 |
| **Button labels** | Always SmileyFace Bold |
| **Colours** | Only `var(--token-name)` in component styles — never a raw hex |
| **Icons** | Strata icon font (`ico ico-*`) — never emoji, never a hand-drawn `<svg>` |
| **Spacing** | Scale only: 4, 8, 12, 16, 20, 24, 32, 40, 48, 56, 64 — no intermediate values |
| **Radius** | xs:4 sm:8 md:16 xl:24 2xl:40 |

The one exception to "never a raw hex": the `:root` token block itself, which every
generated stylesheet includes. That's where hex values are *defined* — everything
downstream references them by name.

Full detail lives in `steering/design.md`. When prose and the component sheet
disagree, `assets/strata-component-sheet/index.html` wins.

---

## Files in Your Project

| File | Purpose |
|---|---|
| `DISCOVERY.md` | Problem, users, constraints, research |
| `PRODUCT.md` | Flows, screens, user stories, scope |
| `DESIGN.md` | Layout, components, locked decisions |
| `IDEATION.md` | Created when you first need it — open questions being explored |
| `STATUS.md` | Live progress checklist |
| This file | Command reference (safe to close) |

---

## Need Help?

- "What components are available?" — lists the AOX component blueprints
- "Show me the Switch24 example" — walks through the worked example
- "What's locked vs open?" — reads DESIGN.md's locked decisions and open questions

---

*Tip: pin this to your editor tabs, or close it — you can always ask Kiro to show your available commands.*
