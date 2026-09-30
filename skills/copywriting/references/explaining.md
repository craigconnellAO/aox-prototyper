# Explaining complex things clearly

Read this when the subject is technical or specialist and the reader isn't: an engineering change for a business audience, a UX research finding for executives, a product feature for customers, a design-system concept for people outside the design team.

The test of an explainer isn't whether it's accurate (it must be) but whether the reader could now explain the idea to a colleague. Descriptions list what something is. Explanations make the reader understand why it works the way it does.

## The curse of knowledge

The source material (a spec, a research deck, an engineer's notes) was written by people who already understand the subject, for people who already understand it. It skips the steps that feel obvious to them, and those are the steps your reader needs. It also contains a lot that's true and interesting to its authors and irrelevant to your reader.

So don't summarise the source. Work out what your reader needs to understand to reach the point, and build that path. Leave out anything that isn't on it, however accurate.

## Start from the reader's question

Concepts make sense as answers to questions. Before explaining what something is, establish the problem it solves, in terms the reader has felt themselves. Someone who has watched a checkout page freeze understands why load order matters before you've said "render-blocking". Someone who has had a password stolen already wants to know how passkeys are different.

Open with the problem, then the idea as the answer to it.

## Build from what they already know

Find the nearest thing the reader already understands and anchor the new idea to it. Then add one new idea at a time, and make sure each one is solid before stacking the next on it. If an explanation needs three unfamiliar terms in one paragraph, it's going too fast.

Introduce a technical term only when the reader needs a handle for something you've already explained. Explain first, name second: "The browser can't draw anything until it has finished reading certain files. Developers call these *render-blocking*." That way the term arrives as a label for something already understood, instead of as a word to decode.

Once you've named something, keep calling it by that name. Switching between synonyms makes a newcomer think you mean different things.

## Concrete, then general

Walk through one specific case step by step before stating the general rule. The reader follows the example, sees the pattern, and then the principle confirms what they've just worked out, rather than arriving as an abstraction they have to take on trust.

Pick an example from the reader's world: their product, their customers, their daily work. A hypothetical is fine when it's plainly framed as one.

## Show the mechanism

"Passkeys are more secure" is an assertion. "A passkey never leaves your phone, so there's nothing for a fake login page to steal" is a mechanism. Readers remember and believe mechanisms, and they can use them to reason about new situations.

For each important claim, ask "why is that true?" and include at least one link of the causal chain. You don't need the whole chain, just enough that the claim stops being magic.

## Analogies: choose carefully, then say where they break

A good analogy maps the *mechanism*, not just the general feel. "A passkey is like a key that only works in your own hand" captures something real about how it works. "Passkeys are the Fort Knox of logins" captures only that it's secure, which the reader already knew you were going to say.

- Use one analogy and follow it through, rather than switching between several.
- Say where it stops being accurate ("unlike a real key, you can't lend it to anyone"), so the reader doesn't carry the wrong part forward.
- If you can't find an analogy that maps well, a concrete example does the job better than a strained one.

## Make numbers human-scale

"4 MB" means nothing to most readers; "about eight seconds on a phone on a slow connection" does. Translate numbers into time, money, people or everyday objects the reader can picture. Keep one or two numbers that matter; a paragraph with six statistics has none that stick. (And every number needs a real source or a placeholder; see SKILL.md.)

## Get ahead of the misconception

Most complex topics come with a common wrong idea the reader probably holds ("a faster server would fix it", "two-factor codes are just as good"). Find it, say it plainly and fairly, and show why it doesn't hold. This is often the most useful paragraph in the piece.

## Simplify without saying false things

Leaving detail out is fine. Saying something that isn't true, because it's easier, is not. "Your phone keeps a private key that never leaves the device" is a simplification. "Passkeys can't be hacked" is false. If a precise statement would derail the reader, simplify and flag it lightly ("there's more to it, but this is the part that matters here").

Check your draft against both readers: could the newcomer follow it, and could an expert read it without wincing? You need both.

## Answer "so what does this mean for me?"

The reader didn't come to understand the concept for its own sake. Somewhere, usually near the end, tell them what changes for them: what to do, what to expect, what to ask for, what decision this helps with.

## Suggest visuals where they'd do the work

Some ideas (sequences, comparisons, before-and-after, how parts connect) are much easier to show than to describe. If the piece will be published somewhere that supports images, drop a placeholder where a diagram would help and say what it should show: `[DIAGRAM: page loading in two orders side by side, price appearing first on the right]`. Then write the prose so it still works without the picture.
