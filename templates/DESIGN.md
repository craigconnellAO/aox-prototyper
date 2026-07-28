# Design

<!-- AOX-PROTOTYPER: This template is unfilled. Start a Kiro session and the
     onboarding flow will populate it conversationally, or fill it in by hand.
     Delete this comment once the file has real content in it. -->

> This file extends the AO Design System (`steering/design.md`) with **[project name]**-specific decisions.
> `steering/design.md` is authoritative for all tokens, component blueprints, and anti-patterns.
> This file answers what those tokens *mean* in the context of this project.
>
> Everything in this file is a **locked** decision — settled, and something other work should be built against. If a decision is still being explored, it belongs in this project's `IDEATION.md` instead, via `/ideate-mode`. See `example-switch24/DESIGN.md` for a worked reference, including how a deliberate departure from a locked rule gets cross-referenced to `IDEATION.md` rather than silently overriding it.

---

## At a Glance

*[Fill this first — it's the smallest amount of design context that lets the AI build a correct screen. Everything below it is where each line gets its reasoning.]*

| | |
|---|---|
| **Design direction** | *[the feel, in one line]* |
| **Layout — mobile** | *[...]* |
| **Layout — desktop** | *[...]* |
| **Accessibility target** | WCAG 2.1 AA *[raise it here if this project needs more]* |
| **New colours introduced** | *[none / see §7a exception below]* |

---

## Theme

*[Light/dark, and why — what's the surrounding context this product sits in?]*

---

## Color Strategy

*[Restrained / expressive / etc — and why. Does this project introduce any colours beyond the core AO palette? If so, that's a sub-brand exception and belongs in `steering/design.md` §7a first — this section should reference it, not invent it.]*

| Role | Token | Use in [project] |
|---|---|---|
| Page background | | |
| Surface | | |
| Border / divider | | |
| Primary heading | | |
| Body / labels | | |
| Supporting text | | |
| Primary CTA | | |
| Secondary CTA | | |
| Brand accent | | |
| Success surface | | |
| Error | | |

### Sub-brand accent (if any)

*[If none, say so explicitly — "This project introduces no new colours" — so it's clear the omission was a decision, not an oversight.]*

---

## Typography

AO system fonts apply: **SmileyFace** for headings, **Inter** for all body and UI copy.

[Project]-specific hierarchy:

| Role | Class / Token | Notes |
|---|---|---|
| | | |

---

## Spacing Scale

Use AO spacing tokens throughout. [Project]-specific rhythm:

- *[...]*

---

## Layout

*[Mobile-first? Max content width? Single column vs. multi-panel? What's the flow's shape?]*

---

## Components in Use

From the AO design system (`steering/design.md`):

- *[List the components this project actually uses]*

*[If this project needs a component that doesn't exist in the system, that's a deliberate exception — document it here the way `example-switch24/DESIGN.md` documents its trust-bridge card: what it is, why it doesn't generalise, and a pointer to the reference implementation.]*

Do not introduce components not in the AO system without first checking `design.md` blueprints.

---

## Motion

*[Minimal? Expressive? What's off-limits? Any exception under active ideation belongs in IDEATION.md, cross-referenced from here — not folded in as if it were settled.]*

---

## Tone (copy constraints)

*[CTA label pattern, error message pattern, any words/punctuation this project avoids or reserves for specific moments.]*

---

## Locked Decisions

*[An index of the decisions above that are genuinely settled, with the reason and the date they were locked. Everything in this file is locked by definition — this table exists so the reason survives, because "why did we do it this way?" is the question that gets asked six weeks later when someone wants to change it.]*

| Decision | Reason | Date |
|---|---|---|
| | | |

---

## Open Questions

*[Pointers only. A question listed here must **not** be answered inline in this file — that's the exact failure `/ideate-mode` exists to prevent. Name the question, then resolve it in `IDEATION.md` and bring the settled answer back up into the relevant section above.]*

| Question | Status | Where it's being worked |
|---|---|---|
| | *[open / in ideation / resolved]* | *[`IDEATION.md` §... ]* |

---

## Reference & Inspiration

*[Figma file links, competitor screenshots, moodboards, the prototype that started the conversation.]*

- *[...]*
