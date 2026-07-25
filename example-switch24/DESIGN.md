# Design

> This file extends the AO Design System (`design.md` / v3) with Switch-specific decisions.
> `design.md` is authoritative for all tokens, component blueprints, and anti-patterns.
> This file answers what those tokens *mean* in the context of Switch.

---

## Theme

Light. The user is in checkout or post-purchase — ambient light unknown, but the surrounding ao.com product page is light. Switch screens should feel continuous with the product journey, not like entering a separate app.

No dark mode for the MVP signup flow.

---

## Color Strategy

**Restrained** — tinted neutrals plus the AO brand green as the single action accent.

The core signup funnel (this document's scope — product, basket, checkout, setup, order-complete) introduces no new colours. It uses the AO palette with intent:

| Role | Token | Use in Switch |
|---|---|---|
| Page background | `--gray-10` | All screen backgrounds |
| Surface | `--gray-20` | Card surfaces, step containers |
| Border / divider | `--gray-40` | Section separators, input borders |
| Primary heading | `--type-primary` (`#011f44`) | Screen titles, plan names |
| Body / labels | `--type-secondary` (`#212121`) | All body copy, form labels |
| Supporting text | `--type-tertiary` (`#595d5e`) | Helper text, captions, plan detail |
| Primary CTA | `--action-primary-base` (`#00893e`) | Main proceed button on every step |
| Secondary CTA | `--action-secondary-base` (`#0564c2`) | "Find my number", PAC/STAC help links |
| Brand accent | `--brand-primary-base` (`#12c35a`) | Plan selected state, success confirmation |
| Success surface | `--ui-success` | Activation confirmed, SIM active states |
| Error | `--ui-error` | Porting code validation, form errors |

### Sub-brand accent (Switch-specific)

Switch24 uses the AO brand green as its primary identity colour for the signup funnel above. If a campaign or seasonal moment needs a decorative layer, reach for `palette-steam` (`#c8d1ff`) or `palette-ice` (`#4a6dce`) — these read as tech/connectivity without breaking AO DNA.

**`--switch-purple` (`#8023bd`)** is a separate, sanctioned exception — see `design.md` §7a — scoped to the Switch24 account hub (nav pill/accent, progress-bar fill, banner UI), not to this funnel. Resolved 2026-07-25: it was previously flagged as an undocumented conflict against this file's green-only rule (see `FIGMA-BRIDGE.md`'s account-switch-hub note); it's now folded into the org-wide design.md instead of staying a per-project departure.

---

## Typography

AO system fonts apply: **SmileyFace** for headings, **Inter** for all body and UI copy.

Switch-specific hierarchy:

| Role | Class / Token | Notes |
|---|---|---|
| Screen title | `text-heading-2` | Step header: "Choose your plan" |
| Plan name | `text-heading-3` | E.g. "15GB · Unlimited calls" |
| Price display | `text-heading-2` + `type-primary` | Prominent but not the only thing on screen |
| Body copy | `text-body` | Plan details, confirmations |
| Small print | `text-body-sm` + `type-tertiary` | Contract terms, legal footnotes |
| CTA label | `text-label` | Button text |

**Price display rule:** never use a hero-metric pattern (giant price number, tiny "per month" label). Show price at `text-heading-2` with contract length inline at the same size. Both facts, same visual weight.

---

## Spacing Scale

Use AO spacing tokens throughout. Switch-specific rhythm:

- Step container: `--space-24` padding
- Between plan options: `--space-16`
- Within a plan card: `--space-12`
- CTA bottom padding (thumb zone, mobile): `--space-24` minimum

---

## Layout

Mobile-first, single-column for all signup steps. Max content width: 600px centred on tablet and above. The signup flow is a linear funnel — no sidebar, no split-panel. Each step owns the screen.

Step indicator at top: show progress without showing how many steps remain (reduces perceived friction).

This is the locked default. The trust-bridge component set currently shows the step count explicitly (numbered 1/2/3 list + matching segmented bar), which is a deliberate departure — under active ideation, not yet a rule change. See [IDEATION.md](IDEATION.md#trust-bridge-motion--progress-display) for the reasoning and open questions before generalising this beyond trust-bridge screens.

---

## Components in Use

From the AO design system (`design.md`):

- **Button** (`btn-primary`, `btn-secondary`, `btn-white`)
- **Form inputs** (text, radio, select) — plan selection uses styled radio cards, not native radios
- **Notification / inline validation** — `data-aods="notification"` for PAC/STAC code errors
- **Progress indicator** — step counter at top of funnel
- **Summary row** — plan recap before payment
- **Accordion** — for "what's included", legal terms, FAQ
- **Trust bridge card** (`.tbc-*`, `data-aods="trust-bridge-card"`) — Switch-specific, not in `design.md`. Post-checkout transitional/activation screen: progress ring, numbered step list (done/active/pending), segmented progress bar. Auto-advances to the next step; no manual CTA. Current reference implementation: `outputs/trust-bridge-mobile.html`, `trust-bridge-insurance.html`, `trust-bridge-complete.html`. The exact motion/shimmer/timing treatment is under active ideation — see [IDEATION.md](IDEATION.md#trust-bridge-motion--progress-display) rather than treating the current build as final.

Do not introduce components not in the AO system without first checking `design.md` blueprints. The trust bridge card is the one deliberate Switch-specific exception — documented here rather than in `design.md` because it doesn't generalise beyond this flow.

---

## Motion

Minimal. Step transitions: fade-in only (`opacity: 0 → 1`, 150ms `ease-out`). No slide animations on step changes — the form content shifts too much. No bounce, no spring, no decorative motion.

This is the locked default for ordinary step-to-step navigation. Trust-bridge motion specifically (progress ring, shimmer, tick-off, heading crossfade) is **under active ideation, not locked** — see [IDEATION.md](IDEATION.md#trust-bridge-motion--progress-display) for the current exploratory approach and what's still open. Nothing there should be read as a rule until it's folded back into this section.

---

## Tone (copy constraints)

- Plan names: capability-first ("15GB · Unlimited calls", not "Essential")
- CTA labels: verb + outcome ("Choose this plan", "Activate my SIM", "Transfer my number")
- Error messages: cause + fix ("That PAC code has expired. Request a new one from your current network.")
- No exclamation marks in functional UI. Reserved for activation confirmation only.
