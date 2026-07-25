---
name: ideation
description: Run a structured divergent-then-convergent ideation round for a screen, flow, or interaction-design question — multiple concepts, scored against Nielsen heuristics plus project-specific criteria, then converged into 2-4 winners. Trigger when the user wants several distinct directions explored for a screen/flow (not a single iteration), when a design question has genuinely open alternatives worth comparing side by side, or when following up on an IDEATION.md entry marked Status: open. Use alongside /ideate-mode, which gates whether this work is allowed to touch DESIGN.md yet.
user-invocable: true
argument-hint: "[screen or flow name] [optional: number of concepts]"
---

# Ideation: structured divergence and convergence

A method for generating and narrowing multiple genuinely distinct design directions, rather than iterating serially on one idea. Extracted from the trust-bridge ideation rounds on the AO Switch24 project — see `example-switch24/IDEATION.md` for the full worked history (rounds 1 through 3b) if you want a concrete reference for how this reads in practice.

Always run this under `/ideate-mode`'s ideate mode — see `skills/ideate-mode/SKILL.md`. Nothing produced here goes into a project's `DESIGN.md`/`PRODUCT.md` directly; it goes into that project's `IDEATION.md` until a decision is explicitly locked.

## Method

### 1. Ground the divergence

Before generating concepts, gather what the concepts must be grounded in:

- The project's `DISCOVERY.md` — research findings, abandonment triggers, user problems the concepts should address
- The project's `PRODUCT.md` — brand personality, commercial goals, what the product explicitly is *not*
- `steering/brand.md` — tone of voice, graphic language, colour palette (including any sanctioned sub-brand exception per `design.md` §7a)
- Any existing locked decision in `DESIGN.md` that the concepts must respect or are deliberately testing a divergence from (name the divergence explicitly if so)

### 2. Diverge

Generate a meaningfully different set of concepts — typically 6-8 for a genuinely open question, fewer for a narrower one. "Meaningfully different" means they differ in structural approach or metaphor, not just visual styling. Give each a one-liner and a short name.

Useful divergence technique: assign each concept a different "pole" — e.g. minimal-restraint vs. artifact-heavy vs. reframe-the-metric — so the spread is deliberate rather than accidental variations on the same idea.

### 3. Score

Score every concept against a fixed rubric, 1-5 per criterion:

**Standard six** (Nielsen heuristics, adapt wording to the concept type): status visibility, real-world match, user control, consistency (with the design system and with itself), recognition over recall, minimalism.

**Project-specific criteria** (derive 3-5 from `PRODUCT.md`'s commercial goals and design principles for this project; weight them double if they're the deciding factors for this decision — state the weighting explicitly).

Total and rank. Don't skip the arithmetic — a visible score table is what makes the convergence step defensible later.

### 4. Sharpen with SCAMPER (optional, targeted)

Rather than running SCAMPER (Substitute, Combine, Adapt, Modify, Put to other use, Eliminate, Reverse) across every concept, apply it selectively to the 2-3 highest scorers, or to concepts that scored well on one axis but weak on another, to see if a specific SCAMPER move resolves the weakness.

### 5. Converge

- Name the top-scoring concepts as the round's "winners" — typically 2-4.
- For each rejected concept, note briefly *why* (e.g. "won on speed but delivers no felt completion moment") — this prevents the same rejected idea resurfacing untested in a later round.
- Fold any strong element from a loser into a winner explicitly ("the ta-da beat into B's receipt landing") rather than losing it.
- Build each winner as a working prototype where practical — a scored table is not a substitute for looking at the thing.

### 6. Record, don't lock

Write the round into the project's `IDEATION.md` under a `##` heading for the flow. Include: current state, the concept table with scores, winner prototypes (linked), and an explicit "open questions" list — deliberate divergences from locked `DESIGN.md` rules, anything still unresolved. Never phrase this as a settled rule; that only happens when `/ideate-mode` locks the decision and it moves into `DESIGN.md`/`PRODUCT.md` proper.

## When to run another round

A new round is warranted when: a prior round's winner reveals an internal contradiction under scrutiny (e.g. copy and visual don't agree — this happened in the trust-bridge example's round 3), a stakeholder introduces a new requirement mid-flight, or a simplification pass is explicitly requested against a winner that scored well but reads as "too busy."
