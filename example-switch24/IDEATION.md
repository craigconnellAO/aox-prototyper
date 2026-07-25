# Ideation

> Working notes for screens and flows still under active exploration.
> Nothing in this file is locked — see [DESIGN.md](DESIGN.md) and [PRODUCT.md](PRODUCT.md) for settled decisions.
> When a direction is finalized, fold it into DESIGN.md/PRODUCT.md with a `Superseded <date>` note on whatever it replaces, then remove (or close out) the entry here so it isn't tracked in two places.
>
> **Kept as a worked reference** for `skills/ideation/SKILL.md` — this is the real history behind the trust-bridge component, showing the divergence → scoring → convergence method in practice. The `outputs/trust-bridge-*.html` links below point to ideation variants that were **not** carried into this package (only the 6 polished final-flow screens are, in `prototypes/`) — they remain archived in the original `0_designMDv3` working repository if you need to open one.

---

## Trust bridge motion & progress display

**Status:** open — round 2 explored 2026-07-02; three winner prototypes await review (started 2026-07-01).

**Current implementation** (`outputs/trust-bridge-mobile.html`, `trust-bridge-insurance.html`, `trust-bridge-complete.html`):

- Numbered step list (1/2/3, done/active/pending) plus a matching 3-segment progress bar — both show the total step count explicitly, which is a departure from DESIGN.md's locked "hide how many steps remain" rule.
- Richer per-screen motion than DESIGN.md's locked "minimal, fade-in only" rule: progress ring draws in, shimmer sweep on the active segment, tick-off transition on step completion, heading crossfade. Ease-out curves only, no bounce/spring, `prefers-reduced-motion` respected throughout.
- Built against the signed-off Figma trust-bridge component set (node `4655:18953`), and cross-checked against stakeholder requirement #9 ("customer kept informed throughout — where they are, what's left to complete") and DISCOVERY.md's abandonment research.

### Round 2 — "order complete per step" (2026-07-02)

**New steer (captured 2026-07-01):** each bridge doubles as an *order-complete moment* for the step just finished — reference number, the emails and delivery confirmations that are coming, and friendly delight that the step is done. Applies after checkout, after the MVNO step, and after D&G. *(Not yet in DISCOVERY.md's stakeholder brief — recorded here until it's added there.)*

**Method:** 8 divergent concepts grounded in DISCOVERY.md abandonment research, PRODUCT.md principles, and AO brand voice (Real. Fun. Quick.). Scored 1–5 on six Nielsen heuristics (status visibility, real-world match, user control, consistency, recognition over recall, minimalism) plus four project criteria at double weight (perceived speed, completion trust, brand delight, extensibility). SCAMPER used only to sharpen three concepts (Adapt → receipt stack; Substitute → inbox proof; Eliminate → no-bridge banner).

| # | Concept | One-liner | Score /70 |
|---|---|---|---|
| 2 | Receipt stack | paper receipt drops onto a persistent pile per step | **61** |
| 7 | One thing left | giant numeral counts the remainder down 2 → 1 → done | **59** |
| 1 | Sorted receipts | signed-off card + inline mini-receipt per done step | **58** |
| 3 | Sorted list | ultra-minimal checklist, copy-led delight | 55 |
| 5 | Inbox proof | renders the sent confirmation email as the artifact | 48 |
| 6 | Momentum banner | no interstitial; confirmation banner atop the next step | 48 |
| 4 | Green moment | 900ms full-bleed ta-da splash, then facts | 43 |
| 8 | Beans companion | AO smiley reacts and speaks the receipt | 43 |

Momentum banner won on speed but delivers no felt completion moment and can't mask the checkout → Subscription App handoff. Green moment and companion scored delight but break the product register (orchestrated waits, invented affordances). Losers' best bits were folded into the winners in a convergence round: the ta-da beat into B's receipt landing, minimal restraint into A, persistent chips + countdown framing into C.

**Winner prototypes** — each instruments a different answer to the auto-redirect question:

- [outputs/trust-bridge-idea-a-sorted-receipts.html](outputs/trust-bridge-idea-a-sorted-receipts.html) — *evolve pole.* The signed-off card; done steps expand into mini-receipts. Hybrid advance: 5s countdown on the button + Pause. Final state never auto-advances.
- [outputs/trust-bridge-idea-b-receipt-stack.html](outputs/trust-bridge-idea-b-receipt-stack.html) — *artifact pole.* Receipts pile up, tuck, reopen on tap, fan out at the end. Auto 4.5s + visible "Stay here".
- [outputs/trust-bridge-idea-c-one-thing-left.html](outputs/trust-bridge-idea-c-one-thing-left.html) — *reframe pole.* Countdown numeral + green confirmation chips (Figma order-complete banner style). Manual "Let's go" only, no auto-redirect.
- [outputs/trust-bridge-ideas.html](outputs/trust-bridge-ideas.html) — comparison index, with links back to the round-1 reference build.

Shared receipt facts follow the Figma order-complete mock (node `5034-20168`): order AOL456, £34.95 paid today, finance £14.79 × 24 months, delivery Thu 12 Jun, masked email.

**Deliberate divergences to resolve before locking:**

- C inverts the locked "show progress without showing how many steps remain" rule even harder than round 1 — an explicit countdown numeral. Momentum via seeing the end vs. the locked hide-the-count rationale.
- A drops the done-step strikethrough from the signed-off component; the receipt line carries completion instead.
- Decorative arc bursts use brand green + `palette-steam`/`palette-ice` per DESIGN.md's decorative rule; the AO brand kit also celebrates with coral/lilac — open whether celebration moments may borrow them.
- Bridges sit on `--gray-10` page background per DESIGN.md's role table; the round-1 reference build used white.
- Exclamation budget: one "Ta da!" per journey (B, first bridge only); DESIGN.md reserves exclamations for activation confirmation.

**Build notes:** `ico-mobile` / `ico-shield` don't exist in strata-icons (glyphs render blank — same latent bug in order-complete.html; separate fix task spawned). Verified working: `ico-mobile-phones`, `ico-protection`. All prototypes honour `prefers-reduced-motion`, carry `aria-live` step announcements, and keep 44px touch targets. The navy demo bar at the bottom of each file is prototype chrome for scrubbing the three bridge moments, not product UI.

### Round 3 — one receipt, three lines (2026-07-05)

**Trigger:** critique of B's Figma frames surfaced an internal contradiction — state 3's own subtitle says "Three receipts, one simple monthly bill" while the picture shows three separate artifacts. Three receipts with three reference numbers quietly read as *three purchases*, which fights PRODUCT.md principle 2 (effortless extension: "not buying a second product") and the one-AO-relationship commercial goal. Real-world-match heuristic also favours one receipt: one transaction produces one receipt with line items; three receipts means three tills.

**Concept D — [outputs/trust-bridge-idea-d-one-receipt.html](outputs/trust bridge/trust-bridge-idea-d-one-receipt.html)** (*artifact pole, refined*): one receipt that grows. Each completed step feeds a line onto the same paper — teeth and total slide down, the line drops in, its tick draws (420ms ease-out), a smile-arc puff fires at the seam, and the running monthly total counts up with a subtle bump. Motion carries the per-step completion beat that B carried structurally.

Decisions taken into the prototype (steer captured 2026-07-05):

- **Persistent running total** — "Your monthly" sits on the receipt from step 1 and counts up per step (£14.79 → £24.79 → £30.78). Turns the metaphor into price confidence (PRODUCT.md #4). Kept modest (1.0625rem, same weight zone as line items) to respect the no-hero-metric rule.
- **Lines collapsed by default, tap to expand** — line = icon + name + status + monthly price + tick. Plan ref / policy no. / emailed proofs sit one tap away (progressive disclosure per principle 3).
- **IA consequence:** order no. (AOL456) and "receipt emailed" promote to *receipt-level* facts (masthead/footer); lines carry only product-specific detail. This is the concept's thesis expressed in information architecture.
- Advance model inherited from B: auto 4.5s + "Stay here"; final state never auto-advances. Exclamation budget unchanged (one "Ta da!", first bridge only).

**New open questions (round 3):**

- Does the persistent growing total ever tip into price panic mid-flow, or does calm typography hold it? (User-picked over end-only reveal; needs a gut-check against research.)
- B vs D: does losing the physical "pile" lose too much delight, or does the paper-growth beat carry it?

### Round 3b — simplification sweep, brand-led (2026-07-05)

**Trigger:** review of D — "I like it but it's too busy." D carries ~14 text elements per fold. Round 3b strips the surface back four different ways, each leaning on BRAND.md (supergraphics, full palette, Smiley Face Headline, full-of-beans tone) as the brand team would. All four keep D's advance model (auto 4.5s + "Stay here", final state manual) so the comparison isolates visual language. Each answers "where does trust live?" differently.

| # | Concept | Colour strategy | Trust lives in | Headline flag |
|---|---|---|---|---|
| E | [Light green moment](outputs/trust bridge/trust-bridge-idea-e-light-green-moment.html) | Drenched #BEFCC8 | one fact line | drenched surface departs gray-10 page rule |
| F | [The smile completes](outputs/trust bridge/trust-bridge-idea-f-smile-completes.html) | Committed ON Green on white | the assembling mark + one chip | supergraphic assembles toward smiley: needs brand sign-off |
| G | [Ta da! ticket](outputs/trust bridge/trust-bridge-idea-g-tada-ticket.html) | Full palette (Toast/Heat/Steam/Ice + greens) | ticket stub + tally | two exclamations; Toast/Heat decorative = the coral question made concrete |
| H | [Say it, then go](outputs/trust bridge/trust-bridge-idea-h-say-it.html) | Restrained, type-led | copy + emailed receipt (no artifact) | no on-bridge receipt; white background |

Notes taken into the build:

- **F's assembly uses only sanctioned graphic elements** (smile sections, the o, the counter dot — never the "a", never the actual logo), sidestepping logo-integrity rules while still reading as "your order completes the smile." Smirk → Grin → Smile mirrors BRAND.md's own naming for smile sections.
- **Contrast maths:** ON Green (#12C35A) fails 3:1 as text on white or light green, so it is decorative-only everywhere in E–H (arcs, swashes, ticks). Dark Green carries all drenched-surface text (≈10:1 on #BEFCC8).
- **"Let's go" used once** (G's final CTA), sentence case, not locked up with the logo — honouring BRAND.md's "not a slogan" rule while testing it as a genuine CTA.
- E and H fold the order number / emailed proof into a single fact line; G keeps it on the stub; F splits it chip + so-far line.

**New open questions (round 3b):**

- Which pole reads as "AO checkout" vs "AO campaign"? E and G are loud for a post-payment moment; H may be too bare to reassure. F may be the balance.
- Can a drenched bridge (E) sit inside an otherwise gray-10 checkout without feeling like a channel switch?
- Does F's assembling smile survive brand review, or does "building toward the logo" cross the line the supergraphic rules protect?
- Is one ticket stub (G) enough proof, or does hiding the two earlier stubs undo the completion-trust the artifact poles were built for?

**Open questions — not settled:**

- Advance model: hybrid countdown (A) vs auto + escape (B) vs manual only (C)? Round 1's forced 2.75s redirect is almost certainly too fast to read a receipt.
- How much receipt detail belongs on a bridge before it stops feeling fast? (Research: perceived length drives abandonment.)
- Does the final bridge state duplicate the order-complete page — should it replace it, feed it, or be skipped when the journey ends?
- Is showing the exact step count right for *every* Switch funnel screen, or trust-bridge-only? (Carried from round 1; C leans in hardest.)
- Should the shimmer pattern be reused elsewhere in Switch, or is it trust-bridge-specific? (Carried from round 1 — A keeps it; B and C drop it.)
- May celebration moments use coral/lilac from the AO brand kit, or stay steam/ice per DESIGN.md?

**Do not treat the above as settled.** Nothing here is a DESIGN.md rule until it's explicitly locked in and moved over.

---

## How to use this doc

- Add a new `##` entry per flow/screen under active exploration.
- Each entry: current state, reasoning so far, and an explicit "open questions" list — don't let it read as a finished spec.
- Close out an entry (delete it, or mark `Status: locked — see DESIGN.md`) once the decision is folded into DESIGN.md/PRODUCT.md proper.
