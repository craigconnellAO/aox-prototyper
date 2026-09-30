# The revision pass

Do these passes in order on the full draft. The order matters: there's no point polishing sentences in a section you're about to cut.

## Pass 1: Structure

- **The point.** Reread the one-sentence point you wrote for yourself. Does the article deliver it clearly, and could a reader state it back after one read? If the draft drifted onto a different, better point, that's fine: update the headline and opening to match.
- **The skim test.** Read only the headline, standfirst, subheadings and the first sentence of every paragraph. Do they tell the story on their own? If not, rewrite first sentences so they carry the claim.
- **The opening.** Could you delete the first paragraph and lose nothing? Often yes: the real opening is paragraph two. Cut and see.
- **The ending.** If the last paragraph restates what the article already said, replace it with the implication, the next step, or the one thing to remember. If the paragraph before it ends strongly, stop there.
- **Section moves.** Each section should do something different. Merge sections that repeat; cut ones that don't serve the point, even if they're true and interesting.
- **Length.** Check against the brief. Over by more than 10%? Cut whole paragraphs before trimming words.

## Pass 2: Clarity

Read it as the reader: someone smart, busy, and not inside your head.

- Any term they wouldn't use themselves? Define it in passing the first time, or swap it for a plain one.
- Any "this", "it" or "that" where the reader could lose track of what it refers to? Name the thing.
- Any sentence you had to read twice? Split it, or put the subject and verb next to each other.
- Any claim with no support? Add the example, the reason or the number, or soften it to what you can back.
- Using two names for one thing ("tokens", then "variables", then "design values")? Pick one and stick to it. Varying terms for elegance makes readers think you mean different things.

## Pass 3: Take out the tics

These patterns mark text as generated or padded. Individually most are harmless; together they tell the reader nobody was really paying attention, and the reader stops paying attention too. Search the draft for them and rewrite. If a brand guide deliberately uses one of them, the guide wins.

**Stock phrases.** Replace with the plain word, or delete the sentence if that's all it was doing.

| Instead of | Try |
|---|---|
| In today's fast-paced / digital / ever-changing world… | (delete; start with the actual point) |
| delve into, dive into, deep dive, unpack, explore | look at, explain, or just start |
| navigate (a challenge), landscape, realm, space, ecosystem | name the actual thing |
| unlock, unleash, harness, leverage, empower, elevate, supercharge | get, use, help, improve, or say what actually happens |
| game-changer, revolutionary, cutting-edge, seamless, robust | say what's different, specifically |
| crucial, vital, pivotal, key (as filler) | say why it matters |
| It's worth noting that, It's important to remember that | (delete; just say it) |
| Whether you're a X or a Y… | (delete; you already know who the reader is) |
| At the end of the day, Ultimately, In conclusion, To sum up | (delete) |
| journey, tapestry, testament to, a myriad of | (rewrite plainly) |

**Reflex constructions.**

- *"It's not just X, it's Y" / "X isn't about Y. It's about Z."* Setting up a claim nobody made in order to knock it down. Just say Y. Keep it only if a real reader really does believe X.
- *Threes everywhere.* "Faster, simpler, and more reliable." One triplet is rhythm; one per paragraph is a tic. Often one of the three is the real point and the other two are padding.
- *The fake reveal.* "The result? A 40% drop." "Here's the thing:" "Enter: design tokens." Just say it: "Errors dropped by 40%."
- *Rhetorical questions as transitions.* "So what does this mean for you?" Replace with the statement that answers it.
- *Dramatic fragments.* "Simple. Fast. Effective." Once, maybe. Not as a habit.
- *Announcing instead of doing.* "Let's take a closer look at…", "Now we'll turn to…". Delete and go straight to the content.

**Punctuation and formatting.**

- *Em dashes.* Useful, but models lean on them for every aside and every reveal. Keep a few; turn the rest into commas, colons, brackets or full stops.
- *Exclamation marks.* Enthusiasm comes from what you say, not the punctuation. At most one or two in a whole article, and only where a brand voice calls for it.
- *Bold scattered through paragraphs.* If everything's emphasised, nothing is. Bold is for the rare phrase a skimmer truly must not miss, if that.
- *Bullets and subheadings doing the work that sentences should.* See SKILL.md, "Plan the structure".
- *Emoji in headings.* Only if the house style uses them.

**Hedging and intensifiers.**

- Stacked hedges ("can potentially help to somewhat reduce") read as not knowing. Commit to what you can support and cut the rest: "reduces".
- Intensifiers ("incredibly", "truly", "really", "extremely", "absolutely") usually signal a weak word underneath. Find the stronger, more specific word or the fact that does the job.

## Pass 4: Cut

Go paragraph by paragraph and ask of each sentence: if this disappeared, would the reader notice? Common candidates:

- The first sentence of a paragraph that warms up before the real first sentence.
- A sentence that restates the previous one in different words.
- Transitions that connect nothing: "Now,", "That said,", "With that in mind,", "Of course,".
- Sentences that tell the reader how to feel ("This is exciting because…") instead of giving them the thing that would make them feel it.

A 10–20% cut from a first draft is normal. The piece almost always gets better.

## Pass 5: Facts

- Every number, name, date, quote and study: does it come from the user's material, the project, or something you're certain of? If not, remove it or turn it into a marked placeholder (`[STAT: …]`, `[QUOTE: …]`, `[SOURCE: …]`).
- Hypothetical examples are framed as hypothetical.
- The brand name, product names and any house spellings are exactly right.

## Pass 6: Read it aloud (in your head)

Where you'd stumble, a reader will too. Where it sounds like a press release, rewrite it so it sounds like a person. Where every sentence is the same length, break one up or join two.

---

## A before and after

**Before** (the typical first draft):

> In today's fast-paced world of e-commerce, page speed has never been more important. Whether you're a small retailer or a large enterprise, slow pages can have a significant impact on your bottom line. But what exactly causes slow pages? It's not just about your server — it's about everything your page asks the browser to do. In this post, we'll dive into the key factors that affect page speed and explore how you can unlock faster, smoother, and more engaging experiences for your customers.

**After:**

> Our product pages used to make shoppers download 4 MB of photos before they could see a price. On a phone on a train, that's eight seconds of a blank page, and plenty of people don't wait eight seconds. The fix wasn't a faster server. It was changing the order the page loads things in, so the price and the button arrive first and the gallery fills in behind them.

What changed: the scene-setting and the "whether you're" line went; the vague "significant impact" became a specific cost the reader can picture; the knocked-down strawman ("It's not just…") became a direct statement; the announcement of the article was replaced by the start of it; the triplet of adjectives went. (The numbers here are illustrative. In a real piece they'd come from the user's material, or be placeholders.)
