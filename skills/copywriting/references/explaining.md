# Explaining complex things clearly

Read this when the subject is technical or specialist and the reader isn't: an engineering change for a business audience, a research finding for executives, a product feature for customers, a design-system concept for people outside the design team.

The test: after one read, could the reader explain the idea to a colleague? A description lists what something is. An explanation makes the reader see why it works that way.

## Explain less, better

The biggest risk in an explainer is saying too much. Specialist topics are full of true, interesting detail, and every piece of it you include makes the core idea harder to find. Work out the one or two ideas that make everything else click, explain those well, and leave the rest out. A tight 600-word explanation beats a thorough 1,200-word one, because the reader actually finishes it.

## Beat the curse of knowledge

Source material (specs, research decks, engineers' notes) is written by experts for experts. It skips the steps that feel obvious to them, and those are exactly the steps your reader needs. It also includes lots your reader doesn't need.

So don't summarise the source. Work out what this reader needs to understand to reach the point, build that path, and drop everything off it.

## Start from the reader's problem

Ideas make sense as answers to questions. Open with the problem the concept solves, in terms the reader has experienced: the page that froze, the ticket that stalled, the bill that went up. Then give the idea as the answer.

## Build from what they know

Anchor the new idea to the nearest thing the reader already understands, then add one new idea at a time.

Explain first, name second: "The browser can't draw anything until it has read certain files. Developers call these *render-blocking*." The term then arrives as a label for something already understood.

Once something has a name, keep using that name. Switching synonyms makes a newcomer think you mean different things.

## Concrete, then general

Walk through one specific case before stating the rule. Use an example from the reader's world: their product, their customers, their day-to-day work. One good example is enough.

## Show the mechanism, briefly

"Passkeys are more secure" is an assertion. "A passkey never leaves your phone, so there's nothing for a fake login page to steal" is a mechanism, and readers believe and remember mechanisms. Include one link of cause and effect for each important claim. You rarely need the whole chain.

## Analogies: one, well chosen

A good analogy maps how the thing works, not just how it feels. "A passkey is like a key that only works in your hand" says something about the mechanism. "Passkeys are the Fort Knox of logins" only says "secure".

Use one analogy at most, and add a short clause saying where it breaks ("unlike a real key, you can't lend it out") so the reader doesn't carry the wrong part forward. If nothing maps well, a concrete example does the job better than a strained analogy.

## Human-scale numbers

"4 MB" means little; "eight seconds of blank screen on a phone" means something. Translate numbers into time, money or things people can picture. Keep one or two numbers that matter.

## Name the misconception

Most technical topics come with a common wrong belief the reader probably holds ("a faster server would fix it"). State it fairly and show in a sentence or two why it doesn't hold. This is often the most useful part of the piece.

## Simplify, but don't say false things

Leaving detail out is fine. Saying something untrue because it's easier is not. "Your phone keeps a private key that never leaves the device" is a simplification. "Passkeys can't be hacked" is false. Could a newcomer follow it, and could an expert read it without wincing? You need both.

## Say what it means for them

Before the end, tell the reader what changes for them: what to do, expect, ask for or decide. Then stop.

## Visuals

If a sequence or comparison would be much easier to show than to describe, and the destination supports images, add a placeholder such as `[DIAGRAM: the two loading orders side by side]`. Write the prose so it works without the picture.
