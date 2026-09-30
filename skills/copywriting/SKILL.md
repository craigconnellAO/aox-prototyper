---
name: copywriting
description: Write blog posts and articles like an experienced editorial writer, with one clear point, a reader-first opening, plain explanations of complex ideas, and tight prose with no filler. Use this whenever the user asks for a blog post, article, explainer, thought-leadership piece, newsletter feature, case study write-up or "a post about X", or hands over notes, research, a transcript or a spec and wants it turned into something people will actually read. Also use it when a technical or specialist topic (a product feature, a design decision, UX research, an engineering change) needs explaining to a less specialist audience, even if the user doesn't say "article".
user-invocable: true
argument-hint: "[topic or brief] [optional: audience, length, where it'll be published]"
---

# Copywriting: blog posts and articles

Write like a seasoned editor: someone who knows readers owe them nothing and who has learned that the clearest version is almost always the shortest one. The goal is a piece a busy person reads to the end and could explain to a colleague afterwards.

Two kinds of request come through here:

- **Write from a brief.** A topic, some direction, maybe notes or source material. You produce the finished article.
- **Explain something technical.** The subject is specialist and the reader isn't. The job is to make them understand it. Read `references/explaining.md` before you outline.

## The standard: clear and to the point

Brevity is the main quality bar for this skill, because it's where drafts most often fail. A draft can avoid every cliché and still be twice as long as it needs to be: points made twice, two examples where one would do, paragraphs that end by summing themselves up. Readers feel that length as effort and stop reading.

- **Say each thing once.** If a paragraph ends by restating its own point in different words, delete that sentence.
- **One example per point.** Pick the strongest one. A second example rarely adds understanding; it adds length.
- **One analogy at most per article**, and only if it does real work.
- **Short paragraphs:** one to four sentences. **Short sentences:** most under 20 words; split anything over 30.
- **Every sentence earns its place** by moving the argument forward or supporting it with something concrete. Setup, recap and commentary on what you just said don't.
- **Length is a ceiling, not a target.** If the brief says 1,000 words and the point is fully made in 700, stop at 700. With no length given, aim for 500–800 words.

## 1. Pin down the brief

Get these from the request, the conversation and any files mentioned. If something's missing, choose a sensible default and note the assumption; only ask if you genuinely can't tell what the piece is for.

- **Reader:** who specifically, what they already know, why they'd read it.
- **The point:** the one thing the reader should understand or do afterwards, as a single plain sentence. Everything in the article serves this sentence or gets cut.
- **Length and destination:** company blog, internal wiki, newsletter, LinkedIn.
- **Voice:** see below.

## 2. Voice

**Check for a brand guide.** Look in the project for a tone-of-voice guide: `steering/brand.md` (this repo has one for AO, section 6), a `PRODUCT.md` with brand personality, anything named `brand`, `voice` or `style-guide`. If the piece is published by that brand, write in its voice and follow its hard rules exactly (name spelling, banned phrases, inclusive language, UK or US spelling). A guide for one brand doesn't apply to work for another client. A warm, playful brand keeps its personality in long-form, but it comes through in word choice and the odd well-placed aside, not in extra sentences.

**With no guide, use a plain editorial voice:** a knowledgeable person explaining something to a smart colleague from another team. Confident, direct, no hype. Contractions and "you" are fine.

## 3. Angle and opening

The angle is the specific way in that makes this reader care. "Page speed explained" is a topic. "Why our product pages were losing shoppers before the price loaded" is an angle. Good angles come from a problem the reader has, a surprise, a concrete story, or a common belief that's wrong.

The first paragraph gets the reader into the second. Start at the interesting part: the problem, the moment, the surprising fact. Don't open with scene-setting ("In today's…"), a definition, an announcement ("In this post we'll…") or a rhetorical question. Keep the opening to two or three sentences.

## 4. Structure

Outline before drafting, in scratch notes rather than the deliverable.

- **Each section makes one move** toward the point: the problem, the mechanism, the example, the objection, the implication. Merge sections that overlap; cut ones that don't serve the point.
- **The skim test:** the headline, subheadings and first sentence of each paragraph should tell the story on their own.
- **Few subheadings, and they say something** ("Why big images stall the whole page", not "The problem"). Under about 500 words, use none. Up to about 800 words, two or three at most. A 1,000-word piece, three or four. A section should run to at least a few paragraphs; if it's only two or three sentences, fold it into its neighbour. Too many headings make an article read like slides and chop up the line of argument.
- **Prose by default.** Arguments live in "because", "so" and "but", and bullets strip those out. Use a list only for steps, parallel options or a checklist. Use a table only when the reader will look things up in it.

## 5. Draft

- **Concrete before abstract.** The example, the number, the scene first; the general rule after.
- **Specific beats impressive.** "Errors dropped from 1 in 12 orders to 1 in 40", not "dramatically improved". No intensifiers to fake it.
- **Show the why, briefly.** One link of cause and effect turns an assertion into something the reader believes. Enough of the mechanism to make the claim make sense, not the whole of it.
- **Handle the obvious objection** in a sentence or two.
- **Plain words, active voice.** "Use", not "leverage". Define jargon once in passing, or replace it.
- **End when the point has landed.** Give the reader the implication or the next step in a line or two. No recap, no "In conclusion", no closing summary list.

### Get the facts right

A fabricated statistic, quote or story can embarrass the author publicly. Use facts from the user's material, the project, or things you're certain of. If the piece depends on facts you don't have and you have web search, look them up from reliable sources and list the sources in your note to the user. Anything you still can't confirm becomes a marked placeholder, e.g. `[STAT: % of orders abandoned at payment]`, rather than a guess. Make it clear when an example is hypothetical.

## 6. Revise and cut

Read `references/revision.md` and do the revision pass before handing over. Expect to cut about a quarter of the first draft. Then check the length with a tool (e.g. `wc -w` on the saved file) rather than estimating; writers routinely undercount their own drafts.

## 7. Deliver

Save the article as a Markdown file if the user is working in a project, named after the headline, and paste it into your reply if it's reasonably short.

```markdown
# [Headline]

*[Standfirst: one sentence on what the reader gets.]*

[Article body]
```

After the article, add a short note to the user, a few lines at most:

- **Other headlines:** two alternatives with different angles.
- **Assumptions:** only ones that affect the piece (reader, length, voice).
- **Check before publishing:** placeholders, facts to confirm, sources used.

**Headlines** tell the reader what they'll get, specifically: "Your returns policy is part of your product", not "Everything you need to know about returns". Sentence case unless the house style differs. No clickbait the article doesn't pay off.
