# The revision pass

Do these passes in order on the full draft. Structure comes first because there's no point polishing a paragraph you're about to delete.

## Pass 1: Structure

- **The point.** Could a reader state your one-sentence point back after a single read? If the draft found a better point along the way, update the headline and opening to match.
- **The skim test.** Read only the headline, standfirst, subheadings and the first sentence of each paragraph. If that doesn't tell the story, rewrite those first sentences so they carry the claims.
- **The opening.** Delete the first paragraph and see if anything is lost. Often the real opening is paragraph two.
- **The ending.** If the last paragraph restates the article, cut it. The piece usually ends better one paragraph earlier.
- **Overlapping sections.** If two sections make the same move, merge them. If a section doesn't serve the point, cut it, however true or interesting it is.

## Pass 2: Cut

This is the pass that matters most. Aim to remove about a quarter of the first draft. Go paragraph by paragraph and ask of every sentence: if this disappeared, would the reader miss anything?

Usually they wouldn't miss these:

- **The paragraph-ending restatement.** A closing sentence that says the paragraph's point again: "That's the whole argument for tokens." "Nothing is broken; the radiators are just the wrong size." "It's a small change with a big impact." Delete it. If the paragraph doesn't land without it, fix the paragraph.
- **The warm-up sentence** at the start of a paragraph, before the one that actually says something.
- **The second example** or the second analogy. Keep whichever is stronger.
- **Explaining the same idea twice for different readers.** Pick the version most of the audience will get.
- **Signposting:** "Let's look at…", "Here's why:", "This is where it gets interesting", "It's worth explaining…". Just say the thing.
- **Commentary on your own point:** "This matters because…" followed by what the reader could already see. "It sounds odd, but…".
- **Transitions that connect nothing:** "Now,", "That said,", "With that in mind,", "Of course,".
- **Telling the reader how to feel** ("This is exciting because…") instead of giving them the fact that would do it.

Then compress what's left:

| Wordy | Tight |
|---|---|
| in order to | to |
| is able to, has the ability to | can |
| the fact that | (usually delete) |
| a number of, a variety of | some, several, or the actual number |
| at this point in time, currently | now (or nothing) |
| it's important to understand that X | X |
| there are several things that cause X | X has several causes |
| make a decision, carry out an assessment | decide, assess |
| can potentially, may possibly | can, may |
| very, really, truly, incredibly, extremely | (delete, or use a more precise word) |

Split any sentence over about 30 words. Merge two short sentences if they say one thing.

## Pass 3: Clarity

Read as the reader: smart, busy, not inside your head.

- Any term they wouldn't use? Define it in passing once, or swap it for a plain word.
- Any "this", "it" or "that" where they could lose track of what it refers to? Name the thing.
- Any sentence you had to read twice? Rewrite it with the subject and verb close together.
- One name per thing. If you call it "tokens", don't switch to "variables" and "design values" for variety. Readers assume different words mean different things.

## Pass 4: Take out the tics

These patterns mark text as generated or padded, and readers stop trusting a piece that's full of them. If a brand guide deliberately uses one, the guide wins.

**Stock phrases.** Delete, or replace with the plain word:

- *In today's fast-paced / digital world…*: delete; start with the point.
- *delve into, dive into, deep dive, unpack, explore*: look at, explain, or just start.
- *navigate, landscape, realm, ecosystem, journey, tapestry*: name the actual thing.
- *unlock, unleash, harness, leverage, empower, elevate*: get, use, help, improve.
- *game-changer, revolutionary, seamless, robust, cutting-edge*: say specifically what's different.
- *crucial, vital, pivotal, key* used as filler: say why it matters, or drop it.
- *It's worth noting that, It's important to remember*: delete.
- *Whether you're a X or a Y*: delete.
- *Ultimately, At the end of the day, In conclusion, To sum up*: delete.

**Reflex constructions:**

- *"It's not X, it's Y"*: knocks down a claim nobody made. Just say Y, unless the reader really believes X.
- *Threes everywhere* ("faster, simpler and more reliable"): usually one is the real point.
- *The fake reveal* ("The result? A 40% drop." "Here's the thing:"): state it directly.
- *Rhetorical-question transitions* ("So what does this mean for you?"): replace with the answer.
- *Dramatic fragments* ("Simple. Fast. Effective."): once at most.

**Formatting:** few em dashes (use commas, colons or full stops), almost no exclamation marks, no bold scattered through paragraphs, no emoji in headings unless it's house style, no closing summary list.

## Pass 5: Facts

Every number, name, date and quote comes from the user's material, the project, a source you looked up (listed in your note), or something you're certain of. Anything else becomes a marked placeholder. Brand and product names are spelled exactly right.

## Pass 6: Check the length and headings

Save the file and count the words with a tool (e.g. `wc -w`). Don't estimate. If you're over the requested length, go back to Pass 2. If you're well under and the point is fully made, that's fine: the requested length is a ceiling.

Then count the subheadings against the final length. Cutting shrinks sections but leaves their headings behind. Use none under about 500 words, two or three up to about 800, and three or four at about 1,000. Fold any section of only two or three sentences into its neighbour.

---

## Before and after

**Before** (a typical first draft, 117 words):

> In today's world of online shopping, page speed has never been more important. Whether you're a small retailer or a large enterprise, slow pages can have a significant impact on your bottom line. But what exactly causes slow pages? It's not just about your server — it's about everything your page asks the browser to do. When a page loads, the browser has to download all of the images, scripts and styles before it can show anything to the customer. This means that if your images are large, customers are left waiting. In this post, we'll dive into the key factors that affect page speed and explore how you can unlock faster, smoother experiences for your customers.

**After** (49 words):

> Our product pages made shoppers download 4 MB of photos before they could see a price. On a phone on a train, that's eight seconds of blank screen, and many people don't wait. The fix wasn't a faster server. We changed the loading order so the price appears first.

What went: the scene-setting, the "whether you're" line, the rhetorical question, the strawman ("It's not just…"), the general explanation (replaced by one concrete case), and the announcement of what the article will do. The numbers are illustrative; in a real piece they'd come from the user's material or be placeholders.
