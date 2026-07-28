# Product

<!-- AOX-PROTOTYPER: This template is unfilled. Start a Kiro session and the
     onboarding flow will populate it conversationally, or fill it in by hand.
     Delete this comment once the file has real content in it. -->

## Product

*[Product/feature name]*

---

## At a Glance

*[The buildable shape of this product. Onboarding fills this section and the four below it first — they're what the AI reads to generate a screen. The conceptual sections further down (purpose, vision, brand personality, anti-references) are what stop it generating the *wrong* screen; fill those in as they settle.]*

| | |
|---|---|
| **One-liner** | *[what this does, in one sentence]* |
| **Primary flow** | *[the happy path, named]* |
| **Screen count** | *[roughly how many distinct views]* |

---

## User Stories

*[The core stories this delivers. 3-7 for an MVP scope — if you have more, you're probably describing more than one product.]*

1. As a **[user]**, I want to **[action]** so that **[outcome]**.
2. *[...]*

---

## Flows

*[Name each flow, then list its steps. One `###` per flow. These become the build order.]*

### [Flow name]

1. *[...]*
2. *[...]*

---

## Screens

*[One line each — the detail belongs in `DESIGN.md`. "Entry point" matters more than it looks: it's what tells the AI whether a screen needs a back affordance, a nav, or neither.]*

| Screen | Purpose | Entry point |
|---|---|---|
| | | |

---

## Edge Cases & Error States

*[Empty states, validation failures, timeouts, partial data. The AO design system has approved patterns for most of these — see `steering/design.md`. Listing them here is what stops them being invented ad hoc at build time.]*

- *[...]*

---

## Out of Scope (for now)

*[What you're deliberately not doing this iteration. This section does real work — it's what stops scope creep arriving disguised as a helpful suggestion.]*

- *[...]*

---

## Dependencies

*[APIs, services, content from other teams, design assets, sign-offs.]*

- *[...]*

---

## Users

*[Who is the primary user? What are they trying to do, and in what state of mind/urgency? See `example-switch24/PRODUCT.md` for a worked reference.]*

---

## Product Purpose

*[Why does this exist? What's the job it does for the customer, beyond the literal transaction?]*

---

## Vision

*[The one or two sentence version of what "great" looks like for this product.]*

Customers should be able to:

- *[...]*

---

## Commercial Goals

*[Each as a `###` heading — what the business gets out of this, stated plainly.]*

### [Goal name]

*[...]*

---

## Brand Personality

*[3-5 traits this product should feel like, each with a one-line gloss. Pull from `steering/brand.md` for the org-wide voice, then say what's specific to this product.]*

### [Trait]

*[...]*

---

## What [Product] Is Not

*[Explicit anti-references — what this must not become, and what to avoid to stay clear of it. This section earns its place: it's what stops scope/tone creep later.]*

### Not A [Anti-pattern]

Avoid:

- *[...]*

---

## Design Principles

*[Product-level principles — how decisions get made when two good options conflict.]*

### [Principle name]

*[...]*

---

## Accessibility & Inclusion

This product must meet AO accessibility standards and WCAG 2.1 AA requirements.

Requirements include:

- Keyboard accessibility
- Screen-reader compatibility
- Clear focus states
- Sufficient colour contrast
- Mobile-first responsive behaviour
- Accessible form patterns
- Non-colour-dependent feedback

*[Add anything specific to this product beyond the standard floor.]*

---

## Design System

The AO Design System (`steering/design.md`) is the source of truth.

This product should:

- Use approved tokens
- Use approved components
- Follow existing interaction patterns
- Avoid introducing custom visual systems unnecessarily

If this product genuinely needs a sanctioned exception (a sub-brand colour, a bespoke component), that exception gets proposed and recorded in `design.md` §7a — not invented silently in this file. See `example-switch24/DESIGN.md`'s "Sub-brand accent" section for how that resolution reads once settled.

The product's character should come primarily from:

- Information hierarchy
- Layout
- Content strategy
- Tone of voice

rather than from bespoke visual styling.

---

## Definition of Success

*[What does a successful [product] experience let customers do? Tie back to the commercial goals above.]*
