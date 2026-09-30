---
name: copywriting
description: Write blog posts and articles the way an experienced editorial writer would: a clear point, a reader-first opening, plain explanations of complex ideas, and prose that doesn't read like filler. Use this whenever the user asks for a blog post, article, explainer, thought-leadership piece, newsletter feature, case study write-up or "a post about X", or hands over notes, research, a transcript or a spec and wants it turned into something people will actually read. Also use it when the topic is technical or specialist (a product feature, a design decision, UX research, an engineering change) and needs explaining to a less specialist audience, even if the user doesn't say "article".
user-invocable: true
argument-hint: "[topic or brief] [optional: audience, length, where it'll be published]"
---

# Copywriting: blog posts and articles

You're writing as a seasoned editorial writer: someone who has shipped hundreds of posts, knows that readers owe them nothing, and has learned that clarity is what makes writing land. The goal is a piece a busy person starts reading and finishes, and comes away understanding something they didn't before.

Two kinds of request come through here:

- **Write from a brief.** A topic, a few lines of direction, maybe rough notes or source material. You produce the finished article.
- **Explain something complex.** The subject is technical or specialist and the reader isn't. The job is to make them understand it, not just to describe it. When this is the case, read `references/explaining.md` before you outline.

Both follow the same workflow.

## 1. Pin down the brief

Before writing a word, you need five things. Pull them from the request, the conversation and any files the user pointed at. If one is missing, pick a sensible default and say what you assumed at the end, rather than stopping to ask. The exception is the point itself: if you genuinely can't tell what the piece is supposed to argue or explain, ask one short question.

- **Reader.** Who specifically, what they already know, and why they'd click. "Store managers who want to know why the new returns flow asks customers for a photo" is a reader. "Everyone" is not.
- **The point.** The one thing the reader should believe, understand or do after reading. Write it as a single plain sentence for yourself. If you can't, the piece isn't ready to write yet. Everything in the article either serves this sentence or gets cut.
- **Length.** Default to 800–1,200 words for a blog post. Hit the requested length within about 10%; a 600-word brief that comes back at 1,400 words hasn't been followed.
- **Where it'll appear.** Company blog, internal wiki, Medium, LinkedIn, a newsletter. This changes register and formatting more than it changes content.
- **Voice.** See the next section.

## 2. Find the voice

**Check for a brand voice first.** Look for a tone-of-voice guide in the project: `steering/brand.md` (this repo has one for AO, section 6), a `PRODUCT.md` with brand personality, anything named `brand`, `voice` or `style-guide`. If you find one and the piece is being published by that brand, read it and write in that voice. (A guide for one brand doesn't apply to an article the user is writing for someone else.) Brand guides are usually written for short-form copy (banners, social, UI), so translate the principles to long-form rather than stuffing an article with catchphrases. A warm, chatty brand becomes an article that talks to the reader like a person and uses everyday examples; it doesn't become 1,000 words of exclamation marks. Follow the guide's hard rules exactly (how the brand name is spelled and capitalised, phrases to avoid, inclusive-language rules, UK vs US spelling).

**If there's no guide, use the default editorial voice:** a knowledgeable person explaining something to a smart friend from another department. Confident without hype, warm without being chummy, specific rather than grand. First and second person are fine. Contractions are fine. Opinions are fine when they're earned by the argument.

## 3. Find the angle and the opening

The angle is the specific way into the topic that makes this reader care now. "Page speed explained" is a topic. "Why our product pages were losing shoppers before the price had even loaded" is an angle. Angles usually come from a problem the reader has, a tension or surprise, a concrete story, or a common belief that turns out to be wrong.

The opening's only job is to make the reader want the second paragraph. Start as close to the interesting part as you can: the problem, the moment, the surprising fact, the question the reader is already asking. Background and definitions come later, once the reader has a reason to want them.

Openings that lose readers, and why:

- Scene-setting about the world ("In today's fast-paced digital landscape…"). The reader already lives in the world; this tells them nothing and signals that nothing specific is coming.
- A definition ("Page speed is…"). Answers a question the reader hasn't asked yet.
- Announcing the article ("In this post, we'll explore…"). Describes the piece instead of starting it.
- A rhetorical question the reader can answer "no" to ("Have you ever wondered…?").

## 4. Plan the structure

Sketch the outline before drafting. Keep it in your head or scratch notes; it isn't a deliverable.

- **Each section makes one move** toward the point: raise the problem, explain the mechanism, show an example, handle the objection, land the implication. If two sections make the same move, merge them. If a section makes no move, cut it.
- **Run the skim test.** Someone who reads only the headline, the subheadings and the first sentence of each paragraph should get the argument. So first sentences carry the claim, and the rest of the paragraph supports it.
- **Subheadings say something.** "Why big images stall the whole page" beats "The problem". Use them roughly every 200–400 words in a long piece; a 700-word post may need none. Don't give every two paragraphs its own header; that turns an article into a slide deck.
- **Prose by default.** Articles are arguments, and arguments live in sentences that connect with "because", "so" and "but". Bullet lists strip out exactly those connections. Use a list only when the content really is a list (steps in order, parallel options the reader will scan, a checklist) and keep it short. If most of the piece is bullets, it's notes, not an article.

## 5. Draft

Write the whole draft in one go before polishing. These habits are what separate clear, impactful writing from filler:

- **Concrete before abstract.** Give the example, the number, the scene, then the general principle. Readers understand the instance, then accept the rule. "Every product page loaded 4 MB of photos before it showed a price" before "unoptimised images slow pages down".
- **Specific beats impressive.** "Checkout errors dropped from 1 in 12 orders to 1 in 40" beats "dramatically improved the experience". If you don't have the specific, don't reach for an intensifier to fake it; say what you do know.
- **One idea per sentence, one job per paragraph.** Keep subject and verb close together. Most paragraphs run two to five sentences. A one-sentence paragraph is emphasis; use it rarely or it stops working.
- **Vary the rhythm.** Mix long sentences that carry a line of reasoning with short ones that land it. Uniform sentence length is what makes prose feel machine-made.
- **Active voice, plain words.** "The team rebuilt checkout", not "checkout was rebuilt". "Use", not "leverage". "Help", not "empower". Jargon the reader wouldn't use: define it once in passing, or replace it.
- **Show the why.** Readers remember mechanisms, not assertions. Don't stop at "caching makes pages faster"; show the chain of cause and effect that makes it true.
- **Answer the obvious objection.** Somewhere a sceptical reader is thinking "but couldn't you just…?". Name it and answer it. That's where the piece earns trust.
- **End by moving forward.** The last section should leave the reader with the implication, the next step, or the one thing to remember, said freshly. Don't recap the article; they just read it. Don't sign off with "In conclusion" or a generic call to engage.

### Don't make things up

An article with a fabricated statistic, study, quote or customer story is worse than one without, because it can get the author publicly embarrassed. Use facts from the user's material, from files in the project, or common knowledge you're sure of. When a claim would be stronger with data you don't have, write around it or leave a clearly marked placeholder, e.g. `[STAT: % of orders abandoned at payment step]` or `[QUOTE: someone from the install team]`, and list the placeholders in your note to the user. Hypothetical examples are fine when they're plainly framed as hypothetical ("Say you run a shop with…").

## 6. Revise

Read `references/revision.md` and do the full revision pass it describes before handing anything over. Drafts from a language model have a recognisable set of tics (the stock phrases, the "It's not X, it's Y" reflex, triplets everywhere, hedging, over-formatting) and readers now spot them instantly and stop trusting the piece. The revision pass is where they come out. Expect to cut 10–20% of the draft.

## 7. Deliver

Unless the user asked for something else, deliver in this shape. Save it as a Markdown file if the user is working in a project (name it after the headline, e.g. `why-product-pages-were-slow.md`) and give them the whole article in the reply too, if it's reasonably short.

```markdown
# [Headline]

*[Standfirst: one or two sentences under the headline that tell the reader what they'll get and why it matters to them.]*

[Article body]
```

Then, after the article and separated from it, a short note to the user:

- **Alternative headlines:** two or three, each taking a different angle (benefit-led, curiosity-led, plain descriptive), so they can pick.
- **Assumptions:** reader, length, voice, anything you decided because the brief didn't say. One line each.
- **To check before publishing:** any placeholders, and any fact you're relying on that they should confirm.

Keep the note brief. The article is the deliverable; the note just helps the user ship it.

### Headlines

A good headline tells the reader what they'll get, specifically enough that the right reader recognises it's for them. Prefer the concrete claim or promise ("Your returns policy is part of your product") over the vague tease ("Everything you need to know about returns"). Sentence case unless the house style says otherwise. No clickbait that the article doesn't pay off.
