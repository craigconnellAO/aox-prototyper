# Design

> This file extends the AO Design System (`steering/design.md`) with **[project name]**-specific decisions.
> `steering/design.md` is authoritative for all tokens, component blueprints, and anti-patterns.
> This file answers what those tokens *mean* in the context of this project.
>
> Everything in this file is a **locked** decision — settled, and something other work should be built against. If a decision is still being explored, it belongs in this project's `IDEATION.md` instead, via `/ideate-mode`. See `example-switch24/DESIGN.md` for a worked reference, including how a deliberate departure from a locked rule gets cross-referenced to `IDEATION.md` rather than silently overriding it.

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
