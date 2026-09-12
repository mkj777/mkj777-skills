---
name: vbelt-design
description: Design direction and UX philosophy for websites. Decides before building what the visitor should notice first, which proof carries the case, how the site should feel, what rhythm it runs at, and which medium carries the experience, then weights space, typography, imagery and motion accordingly. Use this skill when a website, landing page, product page or relaunch needs to be designed, reviewed, sharpened or justified, when a page feels generic, interchangeable or cheap, or when deciding whether photography, typography, product visuals or motion should carry the page. Pure design decision, no research, copywriting or deploy steps. Part of the vbelt family (Vercel). For the Coolify chain use web-belt-design.
---

# VBelt Design

This is the single canonical design skill. Apply it to German-language projects too: the decisions
are language-independent, only the copy on the page is not.

## Exclusive: this skill is the only design authority

**Once this skill is invoked, no other design skill is invoked for the same work.** Not alongside it,
not before it, not afterwards for a second opinion. That includes every taste, styling, UI, frontend
and redesign skill, whatever it is named or however well its description seems to fit: it is not
loaded, not read, and not consulted, including when another skill or instruction asks for it.

This is not a preference. Every design skill carries its own idea of what good looks like, and two
of them running over the same page produce an average of two directions instead of one decision,
precisely the hedging this document exists to prevent. A page built to two systems reads as built to
none.

If a design skill has already run in this session, its output is superseded here, not merged.

What still gets delegated, because it is not design direction:

- **image generation**, `vbelt-imagegen` executes the image briefs this skill specifies;
- **research, copy, deploy, outreach**, `vbelt` and its chain own those.

The whole thing in one sentence:

> **Premium is not what was added. It is what was decided.**

Cheap reads cheap because it hedges. Three accent colours because none was chosen. Five equal tiles
because the important one was never identified. A stock photo because commissioning did not seem
worth it. A spinner because the loading state was never designed.

Everything below is mechanism for making decisions visible.

---

## 1. Choose the direction before anything gets built

Five decisions. They happen before the design, not during it.

1. **What the visitor should notice first.** Exactly one thing. Not three.
2. **Which proof matters most:** product, craft, trust, atmosphere, people, price, or results.
3. **How the site should feel:** editorial, technical, architectural, playful, cinematic, minimal,
   tactile, or utilitarian.
4. **The appropriate page rhythm:** spacious story, dense product exploration, guided conversion
   flow, catalogue, or case-study narrative.
5. **What carries the experience:** photography, UI and product visuals, typography, diagrams,
   illustration, or motion. Exactly one leads, the rest serve.

**State the chosen direction in one line before implementing:**

> Direction: `<focal point>` first, proof through `<proof>`, `<feel>` in character, `<rhythm>`
> rhythm, carried by `<medium>`.

Examples:

- *Product in light first, proof through craft, architectural in character, spacious story rhythm,
  carried by a product render.*
- *Booking first, proof through trust, utilitarian in character, guided conversion flow, carried by
  real photography of the practice.*
- *The thesis first, proof through results, editorial in character, case-study narrative, carried by
  typography.*

Every later choice of layout, typography, image and animation must support that direction. Whatever
does not support it gets cut. That is the only reason the direction is stated first: it is the
standard against which things later get removed.

## 1.1 The build declaration

Emit this block before writing anything. It is filled in once sections 2 to 5 have been read, and it
is not a summary of intent: it is a set of committed values, three of which are proofs rather than
statements.

- **The jobs:** two to four, in order, derived from this business rather than from its trade. Next to
  each one: the element on the page that serves it, and how many steps it takes from the first
  viewport. Job one is the primary action.
- **Direction:** the one line from above.
- **Character and section spacing:** which character, which value from its range, and which value the
  last comparable project used. Not the same one.
- **Ladder:** which of the three, written out.
- **Type system:** the family or pair, the weights, and which family the last comparable project
  used. Not the same one, unless the brand owns it.
- **Palette:** neutral temperature, the three surface values, the accent, and the single action it is
  reserved for. Where the business already had colours: which ones were inherited, what evidence they
  came from, logo file, stylesheet, repeated interface colour, and what was dropped as campaign,
  widget or incidental colour. Then one line per retained colour: **role, original value, shipped
  value, and the reason if the two differ.** Identical columns are the expected case; a difference
  without a measured reason beside it is drift.
- **The action and its emphasis path:** the one primary action in its exact wording and its
  destination, where it first appears, what treatment the navigation gives it while the hero still
  carries it, and where the emphasis moves after that. State the count for the first screen: filled
  actions visible on load, which must be exactly one.
- **Arrows:** the single place on the page where an arrow appears and why, or the word none, plus the
  count, two at most for the whole page. No button is one of them.
- **Persistence:** sticky or not, in one sentence that names what continuous access buys here and what
  it costs, plus the height the sticky state settles at.
- **Button archetype:** which one from section 7, the quiet treatment derived from it, and which
  archetype the last comparable project used. Not the same one, unless the character is the same.
- **Carrying medium:** which one leads, and what the others are reduced to.
- **Image briefs:** one line per section that needs a visual, each naming its source, real material
  the business owns, or generation through `vbelt-imagegen`, with aspect ratio, subject position
  and the reserved copy area. Sections that carry themselves without an image say so. No slot is left
  open to be filled by a construction later.
- **Hero archetype:** which of the four.
- **Navigation:** the model and the priority as they fall out of the job list, the bar's items in the
  order of that list, and the state block from section 6 with every line filled in. Not a model name
  on its own.
- **The first screen:** the bar's share of it as a value from its range, the height that leaves the
  hero, and which of the two arithmetics applies, bar in flow, hero at `calc(100svh - nav)`, or bar
  overlaying, hero at `100svh` with the bar's height reserved.
- **Footer model:** which of the four, and whether it carries the closing action or stays quiet.
- **Entrance and handoff:** what enters in which order on load, and how the hero hands off into the
  first section.
- **Set-piece:** the one, named, with its one-sentence justification. Or the word none.

Then three proofs, written as numbers rather than as intentions:

1. **The headline fits.** The container width and the font size, and the resulting line count at
   desktop. Not "the headline will fit", but "1100 px container, `clamp(2.5rem, 5vw, 4.5rem)`, seven
   words, two lines".
2. **The contrast holds.** The measured ratio of body text against the surface it sits on, and of the
   CTA label against the accent. Two numbers, both from the values actually chosen, both clearing
   section 3.
3. **The spacing resolves.** The section value divided by the group value, and confirmation that the
   result is the factor the chosen rhythm calls for.

If a proof cannot be written as a number, the decision behind it has not been made yet. Go back and
make it. A declaration full of adjectives is the same page you would have built without one.

## 1.2 Scope is how much surface, never how high the bar

**Scope is the number of surfaces the decisions have to hold across. It is not a quality setting.**
Nothing in this document is skipped because a page is a demo, a pitch, a one-pager or a first
draft. One page still gets the full declaration, the measured contrast, the composed hero, the
entrance and handoff, the chosen navigation model, the designed footer and the one set-piece if the
direction calls for one.

A demo that is designed at half the standard argues against itself: it is the entire argument being
made, and it is the only thing the recipient will ever see. There is no cheaper version of a first
impression.

**When time runs short, cut a section, not the standard.** Four sections that are fully designed
beat eight that are laid out. The page that gets remembered is the one where every part of it was
decided, and a short page with nothing unfinished in it reads as deliberate rather than small.

What genuinely scales with scope is production that depends on material: commissioned or generated
imagery for every section, and real 3D, which needs assets that usually do not exist yet. Where the
material is missing, section 8 already says what to do, compose with what exists rather than
inventing it. That is a constraint on the input, not a discount on the craft.

### When the scope is many pages

The same decisions, now proven across every template rather than on one screen. Write the
declaration **once for the site**, not once per page; a template that deviates needs the
one-sentence reason from section 10 like any other broken rule.

What has to hold across pages, and what nothing on a single page can reveal:

- **One grid.** Same columns, same outer margin, same container width on every template. A subpage
  that quietly introduces its own left edge is the most common way a multi-page site falls apart.
- **One type system and one scale.** The same role for each step, so an h2 on a service page carries
  the same weight as an h2 on the landing page.
- **One navigation, in every state.** Same priority, same model, same state block, and the active item
  correct per page. Pages without a hero do not inherit the landing page's top state by accident: if
  the landing page is quiet over its image, every other template needs its own decided top state
  rather than a transparent bar sitting on a white surface.
- **One footer**, identical everywhere.
- **One spacing factor** between section and group, held across templates rather than per page.
- **Layout families count across the whole site.** A services page repeating the landing page's four
  sections is one page built twice. The requirement from section 11 applies to the sum of pages, not
  to each page in isolation.
- **Entrance and handoff apply per page.** Subpages rarely open with a full hero, so decide what
  their opening is and how it hands off, rather than letting them start with a bare headline in a
  container.
- **One visual language.** Light, palette, crop logic and image role are decided for the site.
  Imagery chosen page by page is how a site ends up looking assembled by several people.

---

## 2. Weighting by character

The principles are the same everywhere. Their **weight** is not. A roofing company does not need
startup aesthetics, a law firm does not need playful typography, a developer tool does not need
fashion serifs without a reason.

| Character | Carried by | Section spacing | Typography | Motion | Imagery |
|---|---|---|---|---|---|
| **editorial** | typography | 120 to 160 px | deliberate pairing, very large steps, calm lines | restrained, reveals | few, large, curated |
| **technical** | UI and product | 80 to 112 px | grotesque, mono for numbers and states | functional only: feedback and state change | real screenshots, never rebuilt |
| **architectural** | grid and light | 160 to 240 px | light weights, wide tracking on caps | slow, calm, one set-piece | depth, light, material edges |
| **playful** | form and colour | 80 to 120 px | bold, high contrast, playable | fast, springy, direct manipulation | illustration, own marks |
| **cinematic** | moving image and light | 120 to 200 px | little text, very large | one staged set-piece, scrub | video, render, atmosphere |
| **minimal** | whitespace | 160 to 240 px | one family, few steps, lots of air | almost none, transitions only | exactly one, but strong |
| **tactile** | material and texture | 96 to 128 px | sturdy weights, palpable contrast | hover physics, material response | macro, grain, surface |
| **utilitarian** | information | 56 to 80 px | maximally legible, clear hierarchy | feedback only | functional, sparse |

Section spacing is desktop, top and bottom of a section. Pick **one value inside the range** and hold
it for the whole page. Do not reach for the same number every time: the range exists so that two
projects with the same character still breathe differently. Mobile runs at roughly half the desktop
value, never below 48 px.

Two characters at once does not exist. One leads. A second may appear as contrast in exactly one
place.

## 2.1 Weighting by proof

The chosen proof decides what goes at the top and what the hero has to show.

| Proof | The hero must show | Typical failure |
|---|---|---|
| **product** | the product large, undisturbed, in good light | product small beside a lot of text |
| **craft** | detail, material, process, close-up | claiming it instead of showing it |
| **trust** | faces, place, verifiable evidence, reachability | a wall of seals with no substance |
| **atmosphere** | a room the visitor can see themselves in | stock photo of somebody else's room |
| **people** | real people from the business, not models | generic team tiles |
| **price** | the number itself, typographically strong | price hidden behind an enquiry form |
| **results** | a before and after, one case, one number with a source | invented percentages |

Never invent a proof that does not exist. If the strongest proof is not verifiable, take a weaker
one that is true. An unsupported claim costs more credibility than the stronger proof would have
earned.

## 2.2 Weighting by rhythm

| Rhythm | Section density | Spacing | CTA cadence |
|---|---|---|---|
| **spacious story** | few, large sections | very generous | one CTA at the start, one at the end |
| **dense product exploration** | many clearly separated blocks | medium, but consistent | a CTA at every decision point |
| **guided conversion flow** | short chain, one question per step | medium, no distraction | one action, visible throughout |
| **catalogue** | grid, one tile class | tight, but flawlessly aligned | a CTA per entry, not globally |
| **case-study narrative** | chapters alternating image and text | generous between chapters | one CTA after the proof, never before |

## 2.3 The spacing scale

Space is the first luxury signal, so it is the one system that must be decided rather than felt.

**Pick a base unit:** 8 px, with 4 px as the half step for optical corrections. Every margin, padding
and gap on the page is a multiple of it. Most screen sizes divide by 8, so values land on whole
pixels instead of blurring.

**Pick a ladder, and not the same one every project.** Three that work:

- *linear:* 8, 16, 24, 32, 48, 64, 96, 128, 160
- *geometric, factor 1.5:* 8, 12, 18, 28, 42, 64, 96, 144, 216
- *doubling:* 8, 16, 32, 64, 128, 256

The linear ladder is calm and forgiving, the geometric one has more tension between levels, the
doubling one is dramatic and needs confident content. Choose one per project, write it down, and use
nothing outside it.

**Three levels of distance, and the ratio between them is the actual rhythm:**

| Level | Between | Typical |
|---|---|---|
| inner | headline and its subline, label and its field, icon and its text | 8 to 24 px |
| group | blocks inside one section | 32 to 64 px |
| section | one section and the next | the range in the character table |

The ratio of section to group is what the eye reads as pace: **factor 2 for dense rhythms, factor 3
to 4 for spacious ones.** Whichever factor is chosen, it stays constant down the whole page. A page
where the gap between sections varies by feel reads as unfinished even when every individual section
is fine.

**Line height sits on the same ladder.** Body line height is a multiple of 4, typically 1.5 to 1.65
of the font size, so text blocks stack on the same rhythm as everything else.

**Optical alignment overrides the grid where the eye disagrees.** Punctuation, icons, round shapes and
italic type routinely need 1 to 4 px of manual correction. The grid is the default, not the referee.

**The horizontal grid is the other half, and it must be invisible.** Nothing on the page may look
freely placed. Navigation, text column, image and CTA sit on the same column lines down the whole
page, and a section that introduces its own left edge for no reason is the single most common source
of the feeling that a page was assembled rather than designed. Decide the column count and the outer
margin once. The grid is the foundation on which space, typography and colour can work at all: get it
wrong and every other decision in this document stops paying off.

---

## 3. What holds regardless of direction

Eight mechanisms, ordered by leverage.

**1. Typography carries the most perceived quality per unit of effort.**
Few weights. Large jumps between levels instead of many similar steps. Body line length 60 to 75
characters. Emphasis through italic or weight **inside the same family**, never by dropping in a
second typeface. Wide tracking on small caps. Restrained size beats maximum size: a page that does
not shout reads as more confident.

**A headline wrapping to four or more lines is a container error, not a copy error.** The usual cause
is display type inheriting the body measure. The 60 to 75 character rule governs paragraphs that get
read line after line; applied to a headline it produces a narrow column and a wall of text. Give
display type its own much wider container and let the words run horizontally, then bring the size down
until it settles at two lines, three at the outside. Size and container are decided together, and a
fluid size (`clamp()` against the viewport) carries that decision across breakpoints without a stack
of overrides. Shortening the copy is the last resort, not the first: the sentence was usually right
and the column was wrong.

**Which typefaces, is itself one of the decisions.** The same sans on every project is the
typographic version of the three equal tiles: not a choice, the absence of one. Type is the voice of
the page, and it is the cheapest way to make two sites by the same hand not look like the same site.

- **If the business already owns a typeface, that wins.** A recognisable brand face is inherited
  material like the logo. Modernise the scale, the rhythm and the pairing around it, not the face.
- **At most two families:** one versatile family for UI, navigation and body, and optionally one
  display family for headlines and editorial moments. A third is a mistake, not a range.
- **At most three primary weights.** Weak hierarchy gets fixed with size jumps and space, never by
  adding weights, sizes or tracking until something finally stands out.
- **Pick against the character from section 2, not against taste.** The type system then drives
  spacing, grid density, casing and headline scale, so choosing it late means retrofitting the page.

| Direction | Type system | Fits |
|---|---|---|
| precise, technical, modern | **Geist** with Geist Mono | SaaS, developer tools, product |
| calm, high-end, neutral | **Manrope** | consulting, architecture, modern brands |
| clear, friendly, versatile | **DM Sans** | services, startups, conversion pages |
| editorial, cultivated | **Instrument Sans** with **Instrument Serif** | studios, interior, fashion, culture |
| technical, credible | **IBM Plex Sans** with Plex Mono | B2B, data, security, finance |
| characterful but readable | **Fraunces** with Instrument Sans | hospitality, food, boutique, creative brands |
| serious, text-driven | **Newsreader** with Source Sans 3 | editorial, education, health, long reads |
| direct, industrial, bold | **Archivo** with Archivo Narrow | trades, architecture, industry, events |

The table is a starting point with proven pairings, not a closed list. Anything outside it needs the
same one-sentence reason section 10 asks for.

- Geist and IBM Plex for precision, systems and technical credibility.
- Manrope and DM Sans for clarity, modern service work and broad readability.
- Instrument Serif, Fraunces or Newsreader against a restrained sans when craft, culture, warmth or
  editorial character should lead.
- Monospace only for small labels, metadata, navigation accents, technical data and interfaces.
  Never for body copy.

**Never pick a display face because it looks expensive.** It has to survive the actual words on the
actual page: the longest headline, the language the site is written in, and 16 px in a footer. German
copy needs umlauts, ß and long compound nouns; a display face that lacks the glyphs or breaks under a
28-character word is the wrong face, however good the specimen looked.

**Load it properly, or the choice does not survive contact with the browser.** Self-host, prefer one
variable font over a stack of static weights, subset to the scripts actually used, and give the
fallback matching metrics (`size-adjust`, `ascent-override`) so the swap does not shift the layout.
Preload only the face that renders above the fold. A typeface that arrives after the first paint
undoes exactly the impression it was chosen for.

**2. Space is the first luxury signal.**
Cheap pages fill every pixel, premium pages let content breathe. One spacing scale for the whole page,
held consistently, built as in section 2.3. Empty margin inside an image is worth as much as empty
margin in the layout.

**3. Colour: inherit what exists, choose what does not, then prove the contrast.**
Three steps, in that order, and the last is not optional.

*Inheriting.* This step runs first, and only when the business already has a site or usable brand
material. It decides which colours are not ours to choose. Where no identity is discernible, no logo
colour, no interface colour that repeats, skip it and choose freely below.

**Classify what is there before taking any of it.** The colours in an existing site are not one set,
and treating them as one is how a rebuild inherits noise instead of identity:

| What it is | Weight |
|---|---|
| Logo, wordmark, documented brand assets | authoritative |
| Interface colours that repeat across pages: buttons, links, navigation, headings | strong evidence |
| Neutrals: the whites, greys, beiges and blacks the site sits on | inform the temperature |
| Semantic colours for error, success, warning | kept as states, never as brand |
| Campaign and seasonal colours | dropped unless the campaign is the business |
| Third-party widgets: booking tools, maps, review badges, chat | not the brand, restyle or contain |
| Incidental colour: photography, banners, old icons, one-off sections | residue, not evidence |

**Never read the palette off pixel frequency.** A screenshot is dominated by whatever is largest, and
what is largest is usually a photograph. A kindergarten with a big green garden picture is not a green
brand, it is a brand with a photograph in it. Read the identity off the logo file, the stylesheet and
its custom properties, and the colours that repeat on buttons, links and navigation across several
pages. Where the picture disagrees with the logo, the logo wins.

**What the new palette inherits, and in which role.** In this document *accent* means the one colour
reserved for the primary action, so the mapping has to be said out loud rather than assumed:

- **One primary brand colour.** If it can carry an action, enough contrast against the surface for a
  label to sit on it, it becomes the accent. If it cannot, it stays as the brand's presence in
  surfaces, headings or illustration, and the accent is derived from it: same hue, lightness and
  chroma moved until it holds.
- **At most one secondary brand colour**, in a role that is named. It never becomes a second action
  colour; the rule that one accent belongs to one action is not relaxed by inheritance.
- **A neutral scale derived systematically**, in one temperature, taken from the brand's own
  temperature where the original had one.
- **Semantic colours for states only**, and derived tints, shades and states never count as further
  brand colours.

**Consolidate rather than reproduce.** Where the original carries many near-identical shades, they
become one tonal family instead of eight hex values that were never decided. Where it carries many
unrelated chromatic colours, keep only those with real brand significance and neutralise or restrict
the rest.

**Start from the original values, literally.** The retained colours enter the new palette as the hex
values they actually are, not as an interpretation of them. Sampling the logo and then shipping
something "cleaner", deeper, softer or more saturated is the most common way a rebuild quietly stops
being the same brand, and it happens without anybody deciding it. The default is: the original value
ships unchanged.

**Move a value only where a measured requirement fails, and only as far as it takes.** Lightness and
chroma may be adjusted for contrast that does not clear section 3, for behaving on both a light and a
dark surface, and for hover, active, disabled and focus states that need to be distinguishable. The
hue stays. Nothing moves for balance, taste, trend or "it looks better slightly darker".

**Write both values down.** In the declaration, each retained colour appears as *role, original value,
shipped value, and the reason if they differ*. A shipped value that differs from the original with no
measured reason next to it is drift, and drift gets reverted rather than argued for. Where the
original passes, the two columns are identical, and that is the normal case.

**The neutrals come from the original too**, where it had any: its greys, its beiges, its off-whites,
and its near-black. A generic grey ramp dropped over an inherited brand colour is what makes a rebuild
of a warm, characterful site come back cold.

**Fidelity against quality.** Brand fidelity outranks personal taste; accessibility outranks an exact
hex value; and where accessibility forces a change, it changes the smallest amount that clears the
number. **Never replace a recognisable brand colour because another one feels more modern or more
premium**, that is a rebrand, and a rebrand happens only when it was asked for.

**Multi-colour brands.** Keep the logo whole, and do not promote every colour in it to an interface
colour. Give them ranks instead: one dominant, one supporting, the remainder restricted to
illustration, icons, category marks or small playful details. Bright colours spread evenly across
buttons, cards, surfaces, headings and navigation is not a colourful brand, it is an unmade decision.

**Derive, do not import.** Lighter and darker variants come from the retained colours rather than from
new hues, and the retained palette then runs everywhere: navigation, buttons, links, focus states,
illustration, section surfaces, footer.

**When the inherited accent collides with the imagery**, the imagery moves. The rule below that an
accent must be foreign to the picture still holds, but with an inherited colour the picture is the
adjustable side: crop it, light it differently, or brief the next one away from that hue. The images
are produced for this page anyway; the brand colour was not.

**What the character still decides.** The rule below that the palette follows the character from
section 2 does not survive contact with an existing brand as a choice of hue. Inheritance sets the
hue; the character sets the deployment, how much chroma the neutrals carry, how large the coloured
areas are, how often the colour appears, how loud it is allowed to be. An inherited hue deployed for
the character is the goal. Swapping the hue to suit the character is the rebrand nobody ordered.

*Choosing.* Which colours belong to the brand, not to this skill. The rules behind the choice:

- **Decide the temperature and hold it.** A warm neutral family and a cool one on the same page is
  the most common reason a site looks assembled rather than designed. Pick warm or cool greys, and
  every surface, border and text tone comes from that family.
- **Three surface values, not seven.** A page background, a raised surface, and a recessed or inverted
  one. More values than that and the hierarchy stops meaning anything.
- **One accent, strictly reserved for the primary action.** Used everywhere, it leads nowhere. A
  second colour is allowed only for real semantic state, error or success, never for variety. And
  within any one viewport exactly one element wears it, section 7 says where the emphasis sits and
  how it moves down the page.
- **When the imagery already carries colour, make the accent foreign to it.** An accent that cannot be
  mistaken for part of the picture is unmissable without being loud.
- **Where nothing was inherited, the palette follows the character** from section 2. Utilitarian and
  technical want low chroma and a legible accent. Tactile and editorial want the neutrals themselves to carry warmth or coolness.
  Playful can afford saturation. Architectural and minimal are usually strongest as one hue at many
  values, because committing to a single hue is itself a decision.
- Avoid pure black and pure white as the extremes. Pure values flatten depth and glare.

*Proving.* Contrast is measured, never estimated, and it is checked before the palette is accepted,
not after the page is built.

- Body text and any text under 24 px: **4.5:1** minimum against its actual background.
- Large text, 24 px and up or bold from 19 px: **3:1** minimum.
- Interface boundaries that carry meaning, button edges, input borders, focus rings, icons that are
  the only label: **3:1** against what sits next to them.
- Focus rings must clear 3:1 against **both** the element and the surface behind it. A ring that only
  works on one of the two is a broken ring.
- Text over photography is measured against the **worst** region it crosses, not the average. If it
  does not hold there, add a scrim, move the text, or crop the image differently.
- Never let colour alone carry meaning. State needs a second signal: an icon, a label, a weight.
- A palette that cannot hit these numbers is the wrong palette. Adjust the colour, do not lower the
  requirement.

**4. Own visual language instead of stock.**
Commissioned photography, own render, own illustration, or texture. The extra effort *is* the quality
signal. One strong image beats four generic ones. Where a product screenshot is needed it is real and
large, captured from the running interface and never rebuilt out of divs or SVG. If the real product
can stand in the hero, that beats any preview. Every image slot is filled by a produced image file,
never by a construction, the rule and the production path are in section 8.

Generated imagery is allowed, lying with it is not. Never present a generated person, room, project
or product as a real fact about a real business. Use existing product photos as the factual basis and
generate environment, light or explanatory graphics around them, but do not alter a recognisable
product property. Do not bake meaningful body copy into a generated image. The logo is used unchanged
and only for identification.

**The business's own photographs are real material, and real material is the point.** Pictures from
the existing site showing its rooms, its people, its work and its products are the most credible
things available, and replacing them wholesale with generated imagery trades the one thing a
generated picture can never have. So they are carried over, selectively:

- **Select, do not import everything.** Weak, dated or redundant pictures are dropped, not restored.
- **Where the original holds many real photographs, a meaningful number of them survives into the new
  page.** A rebuild that keeps two and generates the rest has thrown away the business's evidence.
- **The hero image is produced new**, briefed for its slot as section 8 requires, because an existing
  photograph almost never carries the crop, the reserved copy space and the light a hero needs. The
  exception is real: **if the original does hold a photograph that genuinely meets the hero brief, it
  is used** rather than a generated substitute made for the sake of newness.
- **The retained photographs set the visual language, and everything generated is briefed against
  them**, their light, their temperature, their depth. The rule that all images belong to one shoot
  is satisfied by making the new material match the real material, never the other way round.

**5. Depth and material instead of flat fills.**
Shallow depth of field, directed light, real contact shadows, grain, halftone, brushwork. Almost
nothing on a premium page is a flat fill. Grain over a soft gradient is the cheapest premium
technique there is, and it is what saves a gradient from looking like a default.

**6. Restrained interface chrome.**
Borders and icons fine rather than loud. Thin borders, one radius system for the whole page, and the
radii coming from the button archetype chosen in section 7 rather than from a component default. Shadows tinted to the surface underneath them, never
pure black on a light background, and used only where elevation carries real hierarchy. Cards only
when they group something that genuinely belongs together, otherwise a hairline, a divider or plain
space does the job without the box. The attention belongs to the content, not to the operating
surface: chrome that announces itself is the fastest way a page reads cheap.

**7. Motion, motivated and restrained.** See section 4.

**8. The details where most builds stop.**
Focus states. Contrast checked rather than estimated. Skeletons shaped like
the content instead of spinners. Immediate feedback on interaction. Forms that still work with the
on-screen keyboard open. These are invisible when right and fatal when wrong, and they are the
clearest signal that somebody finished the work.

---

## 4. Motion

Motion decides whether a tidy page reads as expensive. It is also where most pages fall apart.

### The rule above all others

Before any animation: **what does it communicate?** Valid answers are hierarchy (directs attention to
the right thing), storytelling (reveals in a sequence that matches the content), feedback
(acknowledges an action), and state transition (shows something changed). Invalid answer: "it looked
good". If the reason cannot be said in one sentence, the animation is dropped.

And: **claimed motion is shown motion.** Either the page genuinely moves, or motion goes to zero and
the page is cleanly static. Half-built motion with cut-off triggers and jumpy entries is worse than
none.

### Durations

| Case | Duration |
|---|---|
| perception floor | ~100 ms |
| simple feedback (toggle, hover) | 100 to 150 ms |
| standard transition, desktop | 150 to 200 ms |
| standard transition, mobile | ~300 ms |
| element entering | ~225 ms |
| element leaving | ~195 ms |
| large, complex transition | ~375 ms |
| practical ceiling | 400 ms |
| feels like a drag | 500 ms and up |

Two refinements that matter more than the base numbers:

- **Exits are faster than entries**, by roughly 50 to 100 ms. Symmetric timing reads sluggish on the
  way out.
- **Duration scales with distance and surface change.** One fixed duration applied to every distance
  is a reliable sign that nobody thought about it.

The hero choreography is the one permitted exception upward: 500 to 800 ms with a 60 to 120 ms offset
between elements. That is a first impression, not a UI response.

### Easing

| Curve | Value | Use |
|---|---|---|
| standard | `cubic-bezier(0.4, 0, 0.2, 1)` | movement between two visible states |
| deceleration | `cubic-bezier(0, 0, 0.2, 1)` | elements entering |
| acceleration | `cubic-bezier(0.4, 0, 1, 1)` | elements leaving |
| expo-out | `cubic-bezier(0.16, 1, 0.3, 1)` | reveals, hero entries, scroll reveals |

- **Never linear**, except for genuinely continuous motion: marquee, scroll-scrubbed timeline,
  rotation.
- **Ease-out for entries.** A fast start reads as responsive, a slow settle gives the eye time. This
  is the normal case.
- **Ease-in for exits.**
- **Asymmetric acceleration and deceleration reads as more natural than symmetric ease-in-out.** The
  long soft landing of expo-out is precisely what gets read as expensive.
- Spring physics instead of easing wherever something is directly manipulated.
- **Same components, same curve, same duration.** A page where every transition has its own timing
  feels restless even when each transition is individually fine.

### House default for scroll reveals

600 ms duration, 60 ms stagger per item, 24 px of travel, expo-out, fires once, at roughly 30 per
cent visibility. That covers the majority of pages.

### Exactly one set-piece

One pinned section, one horizontal pan, one scrubbed sequence, or one 3D moment. **One.** The
set-piece is what people remember. Two cancel each other out. Beyond that, at most continuous ambient
motion at very low amplitude, which is what makes a page feel alive rather than printed.

Ambient motion should come out of the composition rather than sitting on top of it: a slow camera
drift, a reflection changing, fabric or liquid settling, depth responding to the cursor, a masked
reveal, a product changing state in context. What that rules out is the decoration layer that has
nothing to do with the image underneath it: looping particles, floating shapes, heavy parallax, and
something moving in every single section because the section looked static.

### When the set-piece is 3D

Only reach for real 3D when form, function, material, variants or operation become easier to
understand through it. If it is decoration, the answer from the rule above already applies.

- In React projects use React Three Fiber with Drei, otherwise Three.js directly. Use existing
  GLTF, GLB, CAD or product assets when their licensing is settled.
- Pick one staging: a controlled camera move, a scroll reveal, an exploded view, a material or
  colour change, interactive hotspots, or a legible functional sequence. Not several at once.
- With no dependable 3D model, build a high-quality 2.5D staging out of real cut-outs, layers, light
  and depth rather than inventing geometry or details.
- Load 3D on demand, show an optimised poster immediately, cap device pixel ratio and texture sizes,
  compress models (Draco or Meshopt, KTX2), and pause rendering outside the viewport.
- Provide an equivalent static presentation for `prefers-reduced-motion`, small devices, slow
  connections and missing WebGL. Never block content, CTA or navigation behind the asset.

### Technical limits

- Animate only `transform` and `opacity`. Never `top`, `left`, `width`, `height`, `padding`,
  `margin`: each of those triggers layout every frame.
- No `window.addEventListener("scroll")`, no scroll position held in component state, no
  `requestAnimationFrame` loop that touches state. Use motion values, ScrollTrigger,
  IntersectionObserver, or CSS scroll-driven animations instead.
- Grain and noise layers only on fixed, pointer-transparent elements, never on scrolling containers.
- Do not mix two animation libraries in the same component tree.
- **Guard against horizontal overflow.** Elements that start off-screen, full-bleed blocks and
  anything translated on the x axis will produce a horizontal scrollbar that shows up on some
  viewport widths and not others. Clip it at the page wrapper and check narrow widths before
  shipping. This is worth its own line because the motion this document asks for is what causes it,
  and because on a phone it turns the whole page into something that slides sideways under the thumb.
- `prefers-reduced-motion` gets an **equivalent** presentation, not a broken subset. Infinite loops,
  parallax, scroll hijack and pointer physics disappear entirely there.

---

## 5. Composition and craft

### Four hero archetypes

Pick the one that matches what carries the page from section 1. Each is a better starting point than
"headline, subline, two buttons, three cards", which is the shape a page takes when nobody chose.

1. **Full-bleed image with type in the corners.** The image carries the feeling, typography sits at
   the edges, one accent CTA. The centre belongs to the image.
2. **Typography as the layout.** The headline is scaled to the viewport, not to a text container. The
   background is texture only.
3. **Product in a staged space.** Real screenshot or render in a lit, dimensional environment with
   contact shadows.
4. **The working product itself.** The real interface stands in the hero, which removes the need for
   any preview.

**Scale the intensity to the business, not to the archetype.** A medical practice using the first
archetype with one good photograph of its real waiting room is making the same decision as a hardware
brand using it with a studio render. The structure is identical, the production effort follows what
the business actually is. A modest business gets the composition without the spectacle. What does not
scale down is the decision itself: one image, one message, one action.

### Entrance and handoff

The first impression has two designed moments: how the hero appears, and how it releases the visitor
into the rest of the page. Both are decided, not left to chance. Both are composed on the first screen
as section 6 defines it: the navigation and the hero together are exactly one viewport, so the hero is
sized against what the bar leaves rather than against the full height.

**The entrance.** Choreograph the hero's entry as a sequence with an order: first the stage (image,
surface, light), then the headline, then subline and CTA, and last the navigation settles. Use the
exception from section 4: 500 to 800 ms, 60 to 120 ms offset, expo-out. The sequence runs once on
load, not on every return into the viewport. It never holds the content hostage: without JavaScript
and under reduced motion the hero stands complete immediately, and the LCP element does not wait for
the choreography.

**The handoff.** The seam between the hero and the first section decides whether the page reads as
composed as a whole or as a stack of blocks. The first scroll is a designed moment:

- Let an element bridge the seam, a cropped visual, a surface that continues, an object that
  reaches into the next section. The viewport crop from the devices below exists for exactly this.
- Or make a deliberate contrast cut: the first section changes surface or temperature clearly and
  opens with its own first reveal.
- Tie the navigation's state change to the same threshold, so the handoff and the nav transition
  read as one event, not as two independent triggers.
- A hero that fills exactly one viewport height with an unrelated block starting underneath it is
  not a handoff, it is a slide. No scroll hijacking, and no scroll cue as a substitute for a
  designed seam.

### Reusable devices

Levers, not requirements. Reach for one or two per page, never all of them.

- **Corner anchoring.** Headline top left, body copy bottom left, CTA bottom right, navigation split
  across the top.
- **The viewport crop.** Cut a visual off at the bottom edge. Proves depth without needing a scroll
  cue.
- **Diagonal placement.** Two statements, top left and bottom right, the visual between them. The
  strongest reading path there is.
- **Centred wordmark with split navigation.** Reads as composed immediately, because the default is
  name-left.
- **The inset page frame.** Content inside a visible border with margin all around. That single
  decision turns a web page into an object.

The first two are quiet and carry anywhere, including a trade business or a practice. The last three
are loud: they announce that the page has been art-directed, so they need a brand that wants to be
seen that way. On a business whose proof is trust, a loud device costs more credibility than the
composition gains.

### Centred or not

Centring works when there is a **stage** to compose against: a photograph, a light source, a field of
colour. It fails when there is only a flat surface behind it, because then centring is not a decision
but the absence of one.

### The footer closes the page

The footer is the last section, not the leftover. It is also where pages that were carefully
designed at the top give themselves away: a row of four columns, a copyright line and two legal
links, in a grid that appears nowhere else on the site.

Every public page gets one. It carries the links the market legally and functionally requires, and
it is composed like every other section: same column lines, same spacing ladder, same type system.
It may change surface, scale, density or typographic weight to read as an ending, that is the point
of it, but it stays the last chapter of this site rather than a component borrowed from another.

Pick one model:

- **Signature footer:** for focused landing pages, premium brands, portfolios and single-purpose
  conversion sites. A final CTA or contact prompt, the name set large as type or a brand statement,
  then a compact line of legal and social links.
- **Structured utility footer:** for service businesses, SaaS, ecommerce and multi-page marketing
  sites. Real navigation, services or products, contact, social and legal grouped into clear
  columns. Group what exists, an invented category to balance a column is a lie about the business.
- **Editorial footer:** for publications, cultural sites, architecture and studios. A strong
  typographic close, a newsletter or contact invitation, selected links and a restrained information
  layer.
- **Product ecosystem footer:** for large platforms. Grouped product, resource, company, developer,
  support and legal navigation, with the hierarchy actually built rather than implied by column
  position.

Rules that hold across all four:

- **The last thing above the footer decides what the footer does.** If the page ends on its final
  CTA, the footer stays quiet. If it ends on content, the footer carries the closing action.
- **Give the primary contact route its real form here.** A phone number is a `tel:` link, an address
  is a route link. The footer is where visitors look for exactly that, and where most pages hide it
  in eight-pixel grey.
- **Contrast is measured here too.** Small text on a dark closing surface is the most common place a
  page quietly fails 4.5:1.
- **No invented logo mark here either.** The rule from the navigation section holds: the name in type,
  never a fabricated monogram, icon or badge, least of all enlarged as a closing graphic.
- **Reserve space for the legally required links of the target market**, for German sites Impressum
  and Datenschutz, prominent and not buried. Never fabricate legal content or write legal text.
- On mobile the footer is a stack, not four squeezed columns. Long link lists collapse into
  accordions or drop entirely.

### Mobile is the primary case

Every section is designed for the narrow width first and desktop is derived from it. Mobile is a
decision made in the concept, not an adjustment made at the end.

- **Decide the reflow per section:** what moves up, what collapses, what is dropped. Never hide
  conversion-relevant content behind `display: none`.
- **The primary path stays reachable in one step at all times.** Call, route, appointment or enquiry,
  without searching and without zooming.
- **Size touch targets generously**, respect safe areas and the usable height while the browser bar
  is visible. No hover state as the only access to a function.
- **Set type sizes, line lengths and contrast for reading in the hand**, not for reading on a
  1440 px display.
- **Plan media load deliberately:** appropriate resolutions, modern formats, fixed aspect ratios so
  nothing shifts while loading, heavy content only when it is needed.
- **Think forms through completely:** correct input types so the right keyboard appears, autofill,
  few required fields, visible errors, and never a submit button hidden behind the keyboard.
- **Heavy staging gets a mobile alternative** that conveys the same content, not a degraded one.

### The favicon

No favicon gets designed here: leave the tab icon out rather than produce another generic mark, and
delete the framework default so no Vite, React or Next logo is left sitting in the browser tab.

---

## 6. Navigation is derived from the site, not styled as a component

A navigation is not a header component with a fixed height, a backdrop blur, a border and a sticky
behaviour that gets carried from the last project. It is a system whose form is read off the site
being built, and whose appearance changes with where the visitor currently is. Decide it in three
steps, in this order: **the visitor's jobs, then the model and priority they imply, then the states.**
Styling is last, and only where a state actually requires it.

#### Step 1: derive the jobs, and read the navigation off them

Nothing here is looked up by trade: a cosmetics shop, a law firm, a dealership and a kindergarten have
nothing in common as categories, and any list of business types is missing the next one that walks in.
What they share is that somebody arrives with something to get done.

**Name two to four jobs, in order.** For a practice: book an appointment, check the speciality fits,
see who would treat me, find the hours and the way there. For a dealership: find the right vehicle
among many, look at it properly, arrange a test drive, book a service slot. Keep it short, because a
page serving seven jobs serves none, and keep the order, because job one becomes the primary action
and takes the accent with it.

If two audiences arrive with genuinely different first jobs, name both and decide which the page
serves. A page built for both serves neither; the second gets its own route, not a compromise.

Everything about the navigation follows from that list.

**The model** comes from the shape of the list rather than from the industry:

| The job list looks like this | Model |
|---|---|
| One job, one conversion, and everything else is a distraction from it | transaction |
| One job, and it is "find the right one among many" | commerce |
| One object, in depth: understand it, then buy it | product story |
| Two to four jobs, and the offering falls into a few destinations of its own | marketing |
| Two to four jobs, but only contact is a real destination and the case is carried visually | immersive |
| The jobs repeat: the visitor works inside the page rather than reading it | hierarchical |

**The priority** is how many of the jobs have to stay reachable from every viewport. None but the
current step is very low. One is low. Two to four is medium. Where finding things is itself one of the
jobs, it is high or very high, because there the navigation has become the product rather than chrome
around it.

**The items** are the jobs that are destinations of their own: each of those gets a place in the bar,
in the order of the list. A job answered inside a section of the page is an anchor, not a bar entry. A
job nobody arrives with, imprint, careers, press, belongs in the footer. Nothing earns a place in
the bar because a competitor has it.

**Priority decides how much the navigation is allowed to disappear.** Very low carries the task and
nothing else. Low and medium may be quiet inside the hero, may compact after it, and may hide on the
way down. High and very high stay present. A shop that hides its categories to keep a hero clean is
trading its own conversion for a screenshot.

Where finding is the job, the failure is well documented: visitors have to reach product categories
directly, and every additional level in between, a generic "Products" entry, a category list that
only exists inside a menu, costs orders, on mobile most of all. Categories outrank help, account and
secondary links visually, not the other way round.

**This gets checked rather than argued.** Each job enters the declaration with the element that serves
it and how many steps it takes from the first viewport, both read off the built page. Two businesses
in the same trade may land on different models, that is the point, but every job has a served,
reachable element or the page is not finished.

#### Step 2: what the chosen model actually does

The models are named for what they do, not for how the bar looks. A model called "transparent sticky
overlay" has decided the appearance before anyone asked what the site is; these decide behaviour, and
the appearance is derived from it afterwards.

- **Immersive.** The navigation is quiet at the top and composed as part of the hero, and may take a
  compact surface once the hero is behind the visitor. The contact route stays reachable throughout,
  because it is the one destination the list contained.
- **Marketing.** The few destinations, the proof and one primary action are discoverable without the
  bar dominating the page. Clarity outranks immersion here, and the local contact path stays one step
  away at all times.
- **Product story.** A minimal global navigation, plus a local bar that appears after the hero and
  carries the chapter being read together with the buy or enquire action.
- **Commerce.** Search, categories, account and cart are permanent and ranked above everything else in
  the bar. Shopping context, chosen category, filter state, cart count, is visible rather than
  implied.
- **Hierarchical.** Sidebar, or a topbar for global controls plus a sidebar for the tree. The current
  position in the hierarchy is always visible, because the visitor returns to it repeatedly.
- **Transaction.** A reduced header: name, current step, a way out. Every link unrelated to finishing
  the task is removed, including the ones that feel harmless.

One model per site. A sidebar next to a full top navigation requires both needs to be real, and a
sidebar as decoration is not a navigation decision but a layout mood. Two businesses in the same trade
may land on different models, and two in different trades on the same one: the job list decides, not
the industry.

#### Step 3: write the states out, then design them

The navigation is designed in states, not in one appearance. Fill this block into the declaration
from section 1.1, every line of it. A line left empty is a state that will be designed by accident,
usually by whatever the component library does by default:

> **Navigation:** `<model>`, priority `<level>`.
> At top: `<how it sits in the hero, and its height as a share of the first screen>`
> After the hero: `<what it becomes, and at which layout boundary>`
> Scrolling down: `<stays / compacts / hides>`
> Scrolling up: `<returns immediately, or nothing to return>`
> Menu or dropdown open: `<surface, contrast, focus trap, what happens to the page behind>`
> Primary action: `<link, ghost or absent while the hero carries it, never a second filled button, and where the emphasis moves after>`
> Active route or section: `<how the current position is marked>`
> Mobile: `<the architecture at narrow width, not the desktop links squeezed>`
> Focus: `<visible ring, sensible order, and nothing the bar can cover>`

Worked example, a dental practice whose jobs are *book an appointment*, *check the speciality fits*,
*see who treats me*, *find the hours and the way there*, four jobs, three of them their own
destination, so: marketing, priority medium, three items plus the action:

> **Navigation:** marketing, priority medium.
> At top: sits over the hero photograph without a surface, name in type left, three links and
> *Termin* right as a plain link in the same weight as the other three, on the same column lines as
> the content, 96 px tall.
> After the hero: at the seam into the first section, opaque warm white, one hairline border, no
> shadow, 64 px tall, links a step smaller.
> Scrolling down: stays. Calling and booking are the whole point of the page.
> Scrolling up: nothing to return, it never left.
> Menu open: mobile only, opaque full-height panel, page behind locked and inert, focus trapped,
> *Anrufen* and *Termin* as the two largest items.
> Primary action: the hero owns it while it is on screen, so the bar keeps *Termin* as a plain link.
> At the same seam, it becomes the filled accent button, fading in over 8 px at the entering value
> from section 4, and it goes quiet again on the way back up into the hero.
> Active route: current page in the accent, weight one step up, no underline animation.
> Mobile: name, a phone button and a menu button. *Termin* stays in the bar as a real item and does
> not move inside the menu.
> Focus: 2 px accent ring with a light offset, visible on both the transparent and the opaque state,
> tab order left to right, nothing landing behind the bar.

A name, a row of links and a rounded CTA dropped into an otherwise default header is not a
navigation decision. It is the shape a header takes when nobody made one.

#### The bar belongs to the first screen, not on top of it

Until the visitor scrolls, the navigation and the opening are **one image**, exactly the size of the
viewport. Not one viewport plus a bar, the usual mistake, where a full-height hero under a bar pushes
its own bottom edge out of sight, so nobody ever sees the composition it was designed as and the seam
into the first section starts below the fold. Not visibly less either, which leaves a dead strip.

**The arithmetic, both cases:**

- **The bar is in flow above the hero.** The hero gets `calc(100svh - var(--nav-h))`, not `100svh`.
- **The bar overlays the hero.** The hero gets `100svh` and reserves the bar's height as top padding,
  so nothing lands underneath it.
- **`svh`, not `vh`, for the first screen.** On phones `100vh` is taller than what is actually visible
  while the browser chrome is showing, so the bottom of the composition is cut off on exactly the
  device that matters most. `dvh` moves while the chrome hides and makes the opening jump.
- Whatever the entrance choreography does, this holds without JavaScript and under reduced motion. The
  first screen is a layout fact, not an animation outcome.

If the page deliberately opens with something other than a full-height hero, a catalogue, a listing,
a documentation index, the rule is unchanged in substance: the first screen is still composed as a
whole, and it shows the bar, the opening, and the beginning of real content. A bar with a lone
headline in empty space is not an opening, it is a page that started late.

**How much of that screen the bar may take is decided by the business, not by a component default.**
Where finding things is the job, the bar is doing the work and has earned the room; where the page
makes its case visually, every pixel the bar takes is one the hero loses:

| Priority | The bar | Share of the first screen |
|---|---|---|
| very low | one row: name, current step, the way out | under 8 % |
| low | one row, wide spacing, very few items | 8 to 12 % |
| medium | one row, the destinations and the action | 10 to 14 % |
| high | one row plus a permanent search field, or two rows | 14 to 20 % |
| very high | two rows: utility above, categories and search below | 18 to 25 % |

Pick one value inside the range and declare it, because **the rest is the hero's budget**: a bar taking
a quarter means the opening is composed for three quarters, headline sized and image cropped for it,
not squeezed afterwards. Two rows in a shop are not clutter; one row of empty chrome on a page whose
case is a photograph is.

At the scroll threshold the bar stops being part of that image and becomes its own layer, with the
states from above. That is the one moment it changes allegiance, and it is the same threshold as
everything else that happens there.

#### Surface only where a state needs it

**Background, border, blur, shadow and height are states, not the default look.** At the top of a page
there is frequently nothing to separate from: no surface, no border, no shadow, and the bar is simply
part of the hero. A separation gets introduced at the moment content actually scrolls underneath and
the two layers would otherwise read as one, or the moment contrast against what passes behind can no
longer be guaranteed.

- **Decide the top state against the real hero**, not against an assumed dark image. Light photograph,
  white surface or a video that changes brightness mid-loop each demand a different answer, and the
  answer may be a scrim under the bar rather than a bar with a surface.
- **A backdrop blur is not premium in itself.** When what passes behind is busy, imagery, dense text,
  video, a table, an opaque surface is the better answer, because readability is the entire purpose
  of the treatment.
- **Height is a state.** The top value comes from the share of the first screen above; the compact one
  is what the bar becomes once the page is running, and it is the value the rest of the page reserves
  for. Both are decided, neither is inherited.
- **The bar sits on the page grid**: same column lines, same outer margin, same type system and same
  spacing ladder as everything else. A navigation with its own left edge is the fastest way to give
  away that the header was built separately.
- **Contrast is measured in every state that has its own surface**, including the open menu, and
  including the transparent state over the worst region of the hero image.

#### Sticky is a decision with a cost, not the default

**Navigation is not made persistent by default.** It buys roughly a fifth faster navigation and more
discovery of whatever sits in the bar. It costs a slice of every screen for the whole visit, a second
element competing with the content, a permanent risk of covering headings and controls, and on an
immersive page the thing that keeps the image from being an image. Which side wins differs between a
shop and a portfolio, so it gets decided rather than inherited from the last project.

**Persistence pays when continuous access is genuinely used:**

- the page is long and the visitor moves between areas repeatedly;
- one action has to stay reachable at any moment;
- search, cart or account are in constant use;
- the navigation itself is extensive;
- the visitor works inside the site rather than reading it.

Typically: larger shops, SaaS, dashboards, documentation, long product pages. In job-list terms, this
is priority high and very high, and usually medium.

**Persistence does not pay, or pays only partly:**

- a short landing page with one linear path;
- a visual portfolio or a storytelling page;
- fashion, architecture, luxury, where immersion is the argument;
- checkout, booking, any multi-step form;
- a page with little navigation whose CTAs repeat in the content anyway.

There the better answers are usually one of: the bar scrolls away with the hero and does not come
back; it returns only on upward scroll; only a small menu or name control stays; a compact local
navigation appears after the hero; the bar becomes a narrow sidebar; or nothing stays except the one
relevant action, promoted once the hero's copy of it has left.

**Weigh it in one sentence before implementation:** space consumed against navigation frequency,
competition against the value of the content, page length and hierarchy depth against how linear the
path is. If the sentence cannot be said, the answer is not sticky.

**The sticky state is small, and it is not the top state.** The share of the first screen belongs to
the bar while it is part of the opening image. Detached, it is chrome over content: at or below
roughly a tenth of the viewport height on desktop, about 90 px on a 900 px screen, and less on a
phone. A bar that was two rows in the opening becomes one row plus its search field.

**Where the visitor came for practical facts rather than an impression**, opening times, admission,
addresses, forms, conditions, the bar is stable, plainly labelled, generous for touch, restrained in
motion, and never hides on the way down. This is a condition, not an industry: it covers a school, a
clinic, a public office and the service page of a manufacturer alike. There reliability is the
argument, not immersion.

Then the mechanics, whichever behaviour was chosen:

- **Tie the change to a layout boundary**, never to an arbitrary small pixel value. The end of the
  hero, the seam from the handoff above, the start of the specifications. One threshold, one event:
  the handoff and the navigation change are the same moment, not two triggers that happen to be close.
- **Hiding on the way down is allowed at priority medium and below.** At high and very high the
  navigation is the task, and hiding it costs more than the reclaimed pixels are worth.
- **A hidden navigation returns immediately on upward scroll**, because the upward scroll is the
  request. Return it fast and without a bounce.
- **No jitter.** Give the direction change a small hysteresis so a wobble near the threshold does not
  flip the bar back and forth, and do not animate the bar continuously against every scroll pixel
  unless that motion is the one set-piece from section 4.
- **The transition animates surface, border, shadow, spacing, height and text colour.** Not a
  transform of the whole bar, not a logo scaling on every pixel, not a dramatic entrance each time.

#### The navigation may never cover anything

A sticky or fixed navigation that lands on a heading, an anchor target, a focused field, an open
dialog or the mobile menu is a broken page, and it is the most common way a designed navigation fails
afterwards. WCAG 2.2 asks explicitly that a focused element is not obscured by sticky chrome, and
`scroll-padding` is the named answer.

Publish the height of the sticky state as a variable and let the page reserve it:

```css
:root { --nav-h: 64px; }        /* the height of the state that is actually sticky */
html   { scroll-padding-top: var(--nav-h); }
[id]   { scroll-margin-top: var(--nav-h); }
```

When the bar compacts, the variable changes with it, so anchors keep landing in the right place.

Four causes, all checked before the page is called done:

- **`fixed` with no space reserved.** The first section starts underneath the bar on load.
- **Anchor targets landing under the bar.** The heading is scrolled to and sits behind the navigation.
- **A `sticky` bar inside an ancestor with `overflow: hidden` or `auto`.** Sticky positions against
  the nearest scrolling ancestor, so a wrapper added for an unrelated reason silently disables it.
- **Stacking.** `transform`, `filter`, `opacity` and `backdrop-filter` create their own stacking
  contexts. A `z-index` escalated to 9999 to fight the symptom breaks the next dialog instead. Fix the
  context, not the number.

Test it explicitly: anchor links, tabbing through the whole page with the keyboard, dropdowns, modals,
the mobile menu, 200 per cent zoom, and sections whose background changes underneath the bar.

#### No invented logo mark

Never construct a mark for the business, no monogram, no initial in a circle or rounded square, no
abstract icon, no leaf, roof, gear, spark or wave beside the name, no generated SVG symbol standing in
for one. The identity in header and footer is the name set in the type system: right face, weight,
size, tracking and colour, on the same rhythm as everything else. That is a wordmark and it is enough.
A fabricated mark is the one element on the page nobody designed, and it takes attention that belongs
to the headline, the proof and the action.

If the business has a real logo, it is used unchanged and only for identification, at a size that
identifies rather than announces. What the file assumes about the surface behind it is decided before
it is placed, not after: see the rule on inherited material in this section. If no usable file exists, the name in type is the answer; never
invent a replacement and never leave a placeholder mark in the build.

## 7. The action, the emphasis and the buttons that carry it

A page has one primary action. Not one per section and not one per component: one action, in one
wording, to one destination. Everything else that can be clicked is either a route towards it or a way
around it, and is styled as such.

**Emphasis is a quantity inside a viewport, not a property a button owns.** A button is not "the
primary button" because of its style token. It is primary because, in the screen the visitor is
currently looking at, nothing else is competing for the same attention. That makes the decision a
composition decision, taken against everything else in that viewport, and it has to be taken again for
each one:

- **one** element carries the accent fill;
- one or two carry a quiet treatment: outline, ghost, or a text link with an underline;
- everything else stays plain, without button styling. A row of links dressed as buttons is a page
  with no primary action and five candidates for it.

#### The landing viewport belongs to the hero

If the hero carries the action, which is the normal case, the navigation does not carry a filled twin
of it. Two identical accent buttons in the first screen destroy the hierarchy in the first second: the
visitor is told twice what matters most, which is the same as being told nothing, and both then read
as chrome. It also spends the accent that section 3 reserved for one job.

Decide the bar's treatment from the navigation priority above:

| Navigation priority | In the first viewport | Once the hero action has left the viewport |
|---|---|---|
| very low, transaction | no action in the bar at all | unchanged |
| low, immersive | the contact route as a plain link, or nothing | a quiet action may appear: ghost or text |
| medium, marketing | the action as a plain link or a ghost, or absent entirely | promoted to the filled accent action |
| high or very high, commerce and hierarchical | utility only, search, cart, account, none of it accent-filled | unchanged; the accent stays on the buy action in the content |

On a short page where the hero action never leaves the screen for long, the fourth option is to leave
the bar without an action at all. Reachability is already guaranteed by the mobile rule in this
section; a second button adds emphasis, not access.

**Count them, do not judge them.** Load the built page, look at the first screen without scrolling,
and count the elements carrying the accent fill. The answer is one. If it is two, the second one is
not "a bit smaller" or "a different shade", it loses the fill entirely and becomes a link, a ghost,
or nothing at all. Two questions settle which one loses:

- **Do they go to the same place?** Then they are one action appearing twice, and the hero keeps the
  emphasis because it is the composition; the bar's copy goes quiet until the handoff.
- **Do they go to different places?** Then one of them is not the primary action at all. Job one from
  the list decides which, and the other one is styled as what it actually is: secondary.

#### It is one action changing place, not a second one appearing

The promotion is a handoff, and it runs on the threshold the navigation already has: the hero leaves,
the bar takes its surface, and the action moves into it. One event, not two triggers that happen to
fire near each other. Animate it the way the bar animates, opacity and a few pixels of offset at the
entering value from section 4, nothing that pops, and reverse it when the visitor scrolls back up, so
the hero regains its own emphasis instead of finding a competitor waiting there.

The test is what a visitor scrolling up and down sees: one action that moves, or two that exist. If it
is two, no handoff was built, a duplicate was.

**Name the action after what happens next, not after the outcome the business would like.** Where the
result is not in the business's gift, admission decided by a municipality or sponsor, availability
held by a third party, a waiting list, a referral, a regulated approval, a button promising the
outcome writes a cheque the page cannot cash, and the visitor finds out one click later. Name the real
next step: the information, the enquiry, the visit, the conversation.

Repeated instances of the action down the page keep **the same wording and the same destination**. The
cadence for how often it repeats is the rhythm table in section 2.2, not enthusiasm. Different wording
means a different action, and a page offering two different actions has to decide which of them it
actually wants; the one it does not want is never accent-filled.

#### Emphasis is judged against what surrounds it

The same filled button is loud on a calm typographic section and nearly invisible over a busy
photograph. So the treatment is chosen against what is actually in the viewport with it, not taken
from a component library once for the whole site:

- Where nothing competes, an action does not need a fill to be primary. Size, position and space are
  enough, and a quiet action inside a very calm composition reads as more confident than a filled one.
- Over a full-bleed image, the answer is usually a solid surface behind the label rather than a
  stronger colour. Contrast is measured against the worst region the button crosses, like any other
  text over photography.
- Where the imagery already carries the accent hue, the accent stops being an accent. Section 3
  already says it: make it foreign to the picture, or the action disappears into the composition.
- A button sitting directly beside a very large headline needs less weight, not more. It is being
  carried by the type.

#### The button family is chosen for the business, not taken from the library

"Primary is filled, secondary is outlined" is the absence of a decision, and it is why so many pages
carry the same two buttons whatever the business is. Emphasis was decided above; this decides the
**form**, which is where the page either sounds like this business or like its framework.

Pick one archetype for the site, from the character in section 2:

| Archetype | Form | Character, and businesses it fits |
|---|---|---|
| **Precise rectangle** | 2 to 6 px radius, flat fill or one hard border, wide label tracking, almost no motion | technical, utilitarian, architectural. Law, finance, insurance, industry, security |
| **Soft rectangle** | 8 to 14 px radius, 44 to 52 px tall, hover shifts the fill by one step | utilitarian, technical, tactile. Trades, practices, local services, B2B software |
| **Capsule** | fully rounded, generous horizontal padding, low threshold, friendly | playful, tactile. Consumer products, apps, wellness, food |
| **Editorial text action** | no container: the label over a rule that draws itself on hover, no suffix glyph | editorial, minimal, architectural. Fashion, culture, studios, publications |
| **Framed action** | transparent fill, one fine high-contrast border, wider tracking, inverts on hover | architectural, cinematic, minimal. Automotive, luxury goods, high-end property |
| **Statement action** | the closing block *is* the action: oversized type, the whole field clickable | cinematic, editorial, playful. Once per page, before the footer, never for a small action |
| **Utility action** | compact, low chroma, tight padding, instant feedback, repeatable without noise | technical, utilitarian. Dashboards, tools, filters, tables |
| **Image-aware ghost** | over photography or video: a solid or scrimmed surface behind the label rather than a heavier colour | cinematic, tactile. Hospitality, travel, property, fashion |

**The capsule is a choice, not the modern default.** Reaching for it because everything is rounded now
is the same move as reaching for the last project's sans.

Then the rules that keep it one family:

- **One archetype carries the site.** A second, quieter one is allowed in exactly one role, usually
  the editorial text action inside long copy or on a list of entries, and never for the primary
  action. Three is a page with no button language.
- **The quiet treatments are derived from the chosen archetype, not borrowed from another.** If the
  primary is a framed action, the secondary is the same frame at lower contrast, not a pill. If the
  primary is a precise rectangle, the secondary is the same corner with a border instead of a fill.
  This is what makes a page look like one hand drew it.
- **Where recognition matters more than expression, the conventional shape wins.** A booking action in
  a practice, a cart action in a shop, a submit in a form: unmistakable first, characterful second.
  Save the unusual geometry for exploration actions, where a moment of curiosity costs nothing.
- **Nothing about the button is invented at the moment it is built.** Its corner comes from the radius
  system, its height and padding are values from the spacing ladder, its label sits in the type system
  at a defined step, its fill is the one accent, and its focus ring already has a measured contrast in
  section 3. The button is where four decisions that were already made meet. If any of them has to be
  invented here, it was never made.
- **States belong to the archetype.** Hover, active, focus, disabled and pending are designed once for
  the family and then hold everywhere, at durations from section 4. A submit that gives no pending
  state is an unfinished button, whatever it looks like at rest.
- **One icon at most, and only when it says something the label cannot.** Never an icon on both
  sides, never an icon plus an arrow, never two glyphs stacked into one label. A button is a label; an
  icon is an exception to that, and two exceptions in one button means neither was needed. Icon-only
  is for utility actions in dense interfaces, and it still carries an accessible label.
- **Never below 44 px of touch target**, whatever the visual height, and the label says what happens
  rather than *Mehr* or *Los geht's*.

#### No emoji, and no arrow by reflex

**Emoji are not used anywhere on the page. There is no case where one is the right answer.** Not in a
button, a link, a heading, a list, a card, a label, a form message, a toast, an alt text or the page
title. Not as an icon, not as a bullet, not as decoration, not "just one" in the footer. An emoji
renders in a font, size, weight and colour the page does not control, drawn in the visual language of
whoever made the operating system, and it changes shape between Apple, Android and Windows: the one
element on a page that was never designed and cannot be. Where a symbol is needed, use an icon from
the one chosen set, a typographic mark, or nothing.

**No button carries an arrow.** A button is a label. The label already says what happens, and a mark
appended to confirm it says only that the label was not trusted. This holds for every archetype, for
primary and secondary alike, for the bar, the hero, the cards, the forms and the footer. A page whose
buttons all end in the same glyph has not decided anything: the arrow has stopped being a mark and
become punctuation, and it reads exactly like the middle dot in section 9.

Outside buttons an arrow still has two honest uses: the step of a sequence where direction carries
real meaning, and a link that leaves the site where that genuinely needs saying. Both are rationed.

- **Two on the whole page, and that is the ceiling.** Not two per section, not two per viewport: two
  on the page, counted on the built page from top to bottom before it is called done. One is the
  better number. A repeating list where the same mark sits on every entry counts as one, because it
  is one decision, but a list is then the page's arrow, and nothing else gets one.
- **Never in the bar and in the first screen at the same time.** If the opening carries one, the
  navigation carries none, exactly as it gives up the filled action while the hero holds it. Two
  arrows in the first screen is the same failure as two accent buttons: the visitor is pointed twice
  and therefore not at all.
- **Name the one place they appear, or write none.** Like the set-piece in section 4, this is declared
  before the build and then held: arrows live in one role on the page, the case list, the step
  sequence, the outbound links, and nowhere else.
- **One arrow language per site**, from the icon set or from the type family, at one weight and one
  optical size. Not `→` in the hero, a chevron on the cards and `»` in the footer.
- **Prefer the quieter alternatives.** A rule that draws itself under the label, the label shifting a
  few pixels, a colour change, or simply nothing. The editorial text action does more with an
  underline than any suffix arrow does.
- **Icons come from one set**, matched to the type weight and optically sized to the label, never
  mixed across sets. An icon-only action still carries an accessible label.

## 8. Imagery: composed, not inserted

An image is not an asset that gets placed into a container once the layout exists. It is part of the
layout: planned crop, deliberate empty space for the copy, colours that belong to the palette, a
direction of movement, and a defined relationship to the sections above and below it. Imagery, motion
and interface are one composed system, or they are three things sharing a page.

**Before any major visual is made or chosen, decide five things.** This is section 1 applied one level
down: declare the job, then produce against it.

- **Its job:** atmosphere, product proof, material detail, human trust, transformation, or a
  deliberate visual pause.
- **Its role in the layout:** full-bleed stage, editorial crop that breaks the grid while the type
  stays strict, masked reveal, product living in an environment rather than in a browser frame,
  layered foreground, or the transition between two chapters.
- **Its composition:** where the subject sits, where the negative space for the copy sits, the focal
  point, how it crops, and what survives at narrow width.
- **Its visual language:** palette, lighting, texture, depth and perspective, matching the page rather
  than matching wherever the image came from.
- **Whether motion adds meaning:** ambient drift, scroll-linked reveal, cursor-led depth, a product
  changing state in context, or none at all.

The rules that follow:

- **Reserve the negative space on the copy side before the image exists.** Adding a scrim afterwards
  is repair, not composition.
- **Never place the subject directly behind readable text.**
- **Match lighting and colour temperature to the palette.** A cool image on a warm page reads as
  borrowed, however good the image is.
- **Fewer, larger, art-directed visuals beat many small generic ones.** Four decorative images in
  cards are worth less than one composed for its slot.
- **Every image on the page belongs to the same shoot.** One light direction, one colour temperature,
  one depth and lens logic, one crop grammar, across all of them. Images decided slot by slot end up
  as a collection of individually good pictures, which is what a page assembled by several people
  looks like. Decide the visual language once for the page, then brief every image against it. Where
  real photographs of the business are being kept, they are what sets that language, and the generated
  material is briefed to join them.
- **No image is judged on its own.** It is judged in its slot, against the copy it has to hold, the
  surface it sits on and the two sections it sits between.
- **Produce for the actual placement and aspect ratio.** One board cropped into six positions later is
  how images stop fitting their sections.
- **Design the desktop and the mobile crop separately** whenever the focal point or the copy space
  would be lost between them.
- **Bleeding past a container or clipping through a mask is a loud device.** It works when the concept
  carries it and looks like an accident when it does not.
- **Motion reveals, deepens or connects. It never decorates.**

**Scale the production, not the method.** A practice with one photograph of its real waiting room runs
the same five decisions as a brand commissioning a studio render: what the image is for, where the
headline sits inside it, how it is lit, how it crops on a phone. The method costs nothing, and it is
what separates a photograph that was placed from one that was composed.

#### Every image is produced as an image, never built out of markup

**An image slot is filled by an actual image file. It is never constructed out of markup, in any
direction, for any reason, at any scope.** Not markup drawn to stand in for a photograph, a product
shot or a scene: not an SVG assembled to imitate one. Not a scene built from divs. Not a CSS-gradient surface standing in for a product. Not a composition of
shapes, blobs, rings or floating cards. Not an arrangement of icons. Not emoji. Not a browser frame,
dashboard, chat window, terminal or phone mockup built from elements. Not a grey box, a skeleton or a
`picsum` link left in as a placeholder to be replaced later.

A built image is the clearest tell that nothing was produced: the shapes are too clean, the light is
nowhere, and the page shows a diagram of an image instead of an image.

**The path is fixed, in this order:**

1. Write the brief for the slot, the five decisions above, in the shape below. The brief is not a
   description of a nice image, it is this page's declared values written out: the palette values, the
   light and temperature the page runs at, the character from section 2, the exact copy area the
   headline needs, the surface the image sits on and what the sections above and below it do. An image
   briefed without them comes back correct and belongs somewhere else.
2. Hand it to `vbelt-imagegen`. That skill exists for exactly this and does the generating.
3. Place the returned file in the slot it was produced for, at its actual aspect ratio.
4. **Judge it in place, in the built page, at both widths**, never as a file on its own. It is
   working when it holds the copy, carries the section's job and reads as continuous with what sits
   above and below it. A file that is beautiful open in a viewer and inert on the page failed, and it
   gets rebriefed rather than kept because it looks good.

Real material outranks generation where it exists: a photograph the business owns, a real product
photo, a screenshot **captured** from the real interface. Where it does not exist, the image is
generated. Those are the only two sources. The hero is the one slot that runs the other way round: it
is produced for its brief unless the existing material happens to hold a photograph that meets that
brief, because a hero has to carry a crop, a reserved copy area and a light that almost no existing
picture was taken for.

**If neither is available, the section is redesigned so that it does not need an image**, typography,
surface, spacing and one strong statement carry it. Dropping the visual is a decision; simulating it
is a claim the page cannot back up.

| The thought | What it actually ships |
|---|---|
| "An SVG illustration is cleaner than a generated photo here" | A drawing where the proof was supposed to be |
| "A quick div mockup shows the product well enough" | The single most recognisable generated-page tell |
| "Placeholder now, real image later" | The placeholder, because later does not come |
| "Generating is slow, the layout is what matters" | A layout with holes in it, judged as a finished page |
| "It is only a demo" | The only thing the recipient will ever see, per section 1.2 |

**Two things are built rather than generated.** A diagram of real structure or a chart of real data,
designed as an interface element and readable at narrow width. And a genuine illustration, where
illustration is the carrying medium from section 1, drawn as deliberate work, in the page's palette,
shipped as its own asset. Neither licenses assembling shapes in place of a photograph: the test is
whether it carries content of its own or merely occupies the slot a picture was meant to fill.

**What a usable brief looks like.** Not *"a premium image for the hero"*, which returns something
stock-shaped. Instead: *"16:9 hero. Architectural studio at blue hour, subject on the right third,
calm dark negative space across the left 45 per cent for a two-line headline. Deep charcoal, warm
brushed-metal highlights, restrained contrast, soft window reflections. No text, no interface, no
logos."* The parts doing the work are the aspect ratio, the subject position, the reserved copy area,
the light, the palette, and what must not appear in the frame.

#### Material that arrives with its own background

A logo file and an inherited photograph both assume what sits behind them. On a new surface the
assumption becomes visible: a white rectangle in a dark section, a halo around a badly cut subject, a
dark wordmark lost in a dark bar, studio white in a tinted section. It is one of the fastest ways a
rebuilt page shows that its parts came from elsewhere.

**Look at what the file actually is before placing it.** A JPEG has a background baked in and cannot
be freed of it by CSS. A PNG may carry real transparency or a white matte that only looks transparent
against white. An SVG may declare its own fills, or inherit `currentColor` and change with the text
around it.

**Decide the surface first, then use the variant that belongs on it.** A real logo needs a light-surface
and a dark-surface version. Where only one exists, the surface adapts to the file: give the mark a
deliberate plate in the value it expects, on the grid and shaped like the rest of the page, or set the
section to that value. The logo stays unchanged, not recoloured, not inverted, not blend-moded.

- **`mix-blend-mode: multiply` is not a cut-out.** It fakes transparency against white only, tints the
  mark on every other surface, and breaks entirely in dark mode. If a cut-out is needed, it is
  produced as a file with a real alpha channel.
- **Contrast applies to pictures of words.** A wordmark, a badge and any image with text baked into it
  are measured against the surface they sit on like any other text.
- **Inherited photographs are checked against the palette**, not just against the layout. Where the
  white balance of a borrowed photo fights the page, the answer is a tighter crop, a surface that
  takes the difference, or replacing it, never a filter dropped over it to force agreement.
- **A borrowed photo on a coloured section needs either a real cut-out or a section that matches its
  background.** Placing studio white on a warm beige and hoping is the visible version of not deciding.

The rules for produced imagery in the section above apply to inherited material too: it is judged in
its slot, in the built page, on the surface it will actually sit on, at both widths.

## 9. What never gets built

Each of these has its full rule elsewhere, or needs none. They are gathered here so the list can be
read in one pass; where a rule is stated in full, that section owns it and this line does not repeat
the reasoning.

Gradients without a reason. Cards inside cards inside cards. Uniform three-column grids of
interchangeable tiles. Body copy over images where legibility suffers. Decoration with no information
value. A micro-label above every section. Scroll cues. Version badges in the hero. Invented precision
in numbers. Locale, time and weather strips without a real reason. Decorative status dots. Two
marquees. Spinners. Pure black and pure white. Looping particles and floating shapes over a composed
image. Standalone decorative visuals dropped into arbitrary cards. The default sans picked again
because it was picked last time. Four footer columns padded out with invented categories. A footer
that is a copyright line and two grey legal links.

And, ruled on in full where they belong: emoji and arrows on buttons (section 7), images built out of
markup (section 8), two set-pieces (section 4), an invented logo mark (section 6), the em-dash
(below).

The list is not a matter of taste. Every item on it is a pattern that is normally applied **without a
reason**.

### Separators, the middle dot and the em-dash

**The em-dash is not used in anything visible on the page.** Not in headlines, eyebrows, labels,
buttons, body copy, captions, quotes, attribution, alt text or the page title, and not as a design
element either. It is the most reliable signature of text nobody wrote by hand. Restructure instead:
two sentences with a full stop, a comma, a colon, parentheses, or a hyphen with spaces around it. The
same goes for the en-dash used as a separator, ranges take a plain hyphen. This governs the page, not
this document.

Wherever a `·` shows up, meta lines, breadcrumbs, footer legal rows, nav items, tags, card metadata,
a location next to a year, first ask what the dot is doing. Usually it is patching a missing visual
hierarchy: items that carry different weight sitting in one flat row, held apart by a character
instead of by design. Fix the hierarchy and the separator question answers itself. Give the primary
item its size and weight, demote the rest, and the row reads without help.

When the items really are equal in rank and the row still needs separating, reach for the quiet
options first: real spacing, a hairline rule, a line break, a column, or a plain word. A middle dot
stays available as one option among those, not the default one. It earns its place when the row is
short, the items genuinely equal, and no cheaper separation works.

**It stays occasional.** One or two on a whole page, in one row that earned it, is the frequency this
is talking about. Once the same dot appears in the meta line, the breadcrumbs, the card footers and
the legal row, it has become the page's punctuation rather than one row's solution. Strings like
`Brand · No. 01 · Lisbon · 2024`, where the dot is doing the whole layout, are the case to avoid.

---

## 10. The rule about the rules

Every rule here is a default for the case where no argument exists. Very good sites break individual
ones regularly, and successfully.

> **A rule is the default for when you have no argument. A reference site is what happens when
> somebody did.**

The method:

1. Apply the defaults. They are right in the overwhelming majority of cases.
2. To do something a default forbids, say the reason out loud in one sentence.
3. If the reason survives being said out loud, break the rule.
4. If the reason is "it looks designed", "it feels premium", or "it looked cool", the default was
   right.

Reasons that hold up: a serif against a technical subject, because the friction is the positioning. A
local time in the navigation, because the studio is defined by its place and the mark runs through
the whole brand. A family switch for exactly one word, because that word carries the product promise.

This is the same test as "motion must be motivated", extended to the whole page.

---

## 11. Pre-flight check

The declaration in section 1.1 committed the values before the work. This verifies what only exists
once the page does. Run it as ten short passes rather than one long list; a pass that cannot be
answered from the built page in front of you has not been run.

**Drift.** Did the built page stay what was declared?

- Does the built page still match the declaration, including the section value, the ladder and the
  accent, or did it drift without the declaration being updated?
- Every section supports the stated direction?

**The first screen.** Load it, look before scrolling.

- First screen loaded and the accent-filled actions counted without scrolling: exactly one? If the
  bar and the hero both carried one, did the second lose the fill entirely rather than being made
  slightly smaller?
- Bar and hero together exactly one viewport, measured on the built page at desktop and at 390 x 844,
  in `svh` rather than `vh`, nothing of the hero cut off below the fold, no dead strip above it, and
  the seam into the first section landing where it was designed to?
- The bar's share of the first screen inside the range its priority allows, and the hero composed for
  the height that leaves rather than squeezed into it?
- Exactly **one** focal point per glance?
- Entrance choreographed, runs exactly once, and the hero stands complete immediately without
  JavaScript and under reduced motion?
- Seam between hero and first section designed, navigation state change tied to the same threshold?

**The action.** One thing wanted, everywhere.

- Exactly one accent-filled action in every other viewport too, checked by scrolling the built page
  rather than by looking at components?
- Does the action name the real next step rather than an outcome the business does not control?
- The action repeated with identical wording and destination, its treatment chosen against what shares
  each viewport with it, and the navigation's copy of it handed over on the same threshold as the
  navigation's own state change rather than existing in parallel?
- Primary path reachable in one step at 390 x 844, without zoom and without searching?

**Navigation.**

- Does every job in the declaration have an element that serves it, reachable in the stated number of
  steps, verified by scrolling the built page rather than by reading the plan?
- Model and priority derived from the job list rather than assumed from the trade, the bar carrying the
  jobs that are destinations and nothing else, and nothing the task depends on, categories, search,
  cart, the call or booking action, hidden to keep a hero clean?
- Every line of the state block designed and checked on the built page: top, after the hero, scrolling
  down, scrolling up, menu open, active route, mobile, focus?
- Surface, border, blur, shadow and height present only where a state needs them, contrast measured in
  every state that has its own surface, and the top state checked against the worst region of the real
  hero rather than an assumed one?
- Scroll behaviour tied to a layout boundary rather than an arbitrary pixel value, no jitter at the
  threshold, and hiding on the way down used only at priority medium and below?
- Persistence justified in one sentence rather than defaulted to sticky, and the sticky state at or
  below roughly a tenth of the viewport height on desktop, lighter still on a phone?
- Sticky height published as a variable with `scroll-padding-top` and `scroll-margin-top` set, anchors
  landing clear of the bar, focused elements never covered, and dialogs and the mobile menu layered
  above it without an escalated `z-index`?

**System.** One of each, held down the page.

- One base unit, one ladder, one section-to-group factor, held down the whole page?
- Same column lines and outer margin down the whole page, no section inventing its own left edge?
- One radius system and one type-family logic, held across all sections?
- One button archetype carrying the site, chosen for the character rather than defaulted to a pill,
  its quiet treatments derived from it rather than borrowed, at most one expressive second archetype
  and never on the primary action?
- Every button's corner, height, padding, label step, fill and focus ring taken from the radius
  system, the ladder, the type system, the accent and the measured contrast, nothing invented at the
  moment it was built?
- Hover, active, focus, disabled and pending designed for the whole family, touch target never below
  44 px, and every label naming what happens?
- No button carrying more than one icon, none with an icon on both sides, and icon-only actions only
  in dense interfaces and with an accessible label?
- Chrome restrained: thin borders, tinted shadows, cards only where they group something real?

**Colour and inherited material.**

- Where the business already had colours: is the identity recognisably intact, read off the logo and
  the repeating interface colours rather than off the biggest photograph, with campaign, widget and
  incidental colours dropped rather than inherited?
- One primary brand colour in a named role, at most one secondary that is not a second action colour,
  neutrals in one temperature derived from it, and no logo colour promoted to an equal interface
  colour just because it exists?
- Shipped colour values held against the originals side by side: identical wherever the original
  passed, and every difference carrying a measured reason rather than a preference?
- Every logo and every borrowed image placed on a surface its file actually suits, no white plate in
  a dark section, no blend mode standing in for a cut-out, no wordmark at low contrast, and checked
  in the built page rather than as a file?
- Contrast: not answered here. Section 8.1 is its own pass and it has to have been run.

**Typography and text.**

- Headline at two lines, three at the outside, in its own wide container rather than the body measure?
- Type system chosen for this project rather than inherited from the last one, at most two families
  and three primary weights, self-hosted and loading without a layout shift?
- Display face checked against the longest real headline and the language of the site, umlauts and ß
  included?
- Line length 60 to 75 characters, no centred multi-line body text?
- Every visible line re-read: nothing stilted, nothing invented, and **not one em-dash anywhere in
  visible text**, headlines, buttons, captions, alt text and page title included?
- Every `·` on the page checked against the hierarchy question: is it holding apart items that should
  have been ranked by size, weight or position instead, and if it stays, is it a short row of
  genuinely equal items rather than the thing carrying the layout? Counted across the whole page: one
  or two, not a separator used everywhere?
- **Zero emoji on the page**, in buttons, labels, headings, lists, cards, form messages, alt text and
  the page title alike?
- **Not one button on the page carrying an arrow**, bar, hero, cards, forms and footer alike?
- Arrows counted top to bottom on the built page: **two at most**, in the one role declared for them,
  one glyph language at one weight, and never one in the bar while the first screen already has one?

**Imagery.**

- Exactly **one** medium carrying the page, everything else serving?
- Is every image own or at least specific material, and is every single one a produced image file,
  real material or generated through `vbelt-imagegen`, with nothing in an image slot built out of
  divs, SVG, gradients, shapes or icons, and no placeholder box left anywhere?
- Every image brief from the declaration actually produced, or its section redesigned to carry itself
  without one rather than left with a hole in it?
- Where the original site held real photographs of the business: are a meaningful number of them still
  on the page, selected rather than imported wholesale, with the generated material briefed to match
  their light and temperature rather than the reverse?
- Hero image produced for its brief, unless an existing photograph genuinely met that brief?
- Does every major visual have a stated job, a layout role and a planned crop, produced at its actual
  placement and aspect ratio rather than cropped out of one board?
- Negative space reserved on the copy side, no subject sitting behind readable text, image light and
  temperature matching the palette?
- Do all images on the page read as one shoot, same light direction, temperature, depth and crop
  grammar, rather than as individually good pictures collected into one page?
- Was every image judged in its slot in the built page at both widths, against the copy it holds and
  the sections above and below it, rather than as a file?
- Desktop and mobile crops designed separately wherever the focal point would otherwise be lost?
- Nothing generated presented as a real fact about a real business, no borrowed photography left in
  as if it were owned?

**Motion and layout behaviour.**

- Can every animation be justified in one sentence? Exactly one set-piece?
- Only `transform` and `opacity` animated, `prefers-reduced-motion` served equivalently?
- No horizontal scrollbar at any width, checked on a narrow viewport after the motion was added?
- Does a layout family repeat? Across eight sections, at least four different ones.

**The finish.**

- Footer composed on the same grid, contrast measured on its surface, contact route real and the
  legally required links present, stacked rather than squeezed on mobile?
- Header and footer free of any invented mark, the name in type, and only a real logo used unchanged?
- Touch targets generous, safe areas respected, forms usable with the keyboard open?
- Focus states visible, keyboard order sensible?
- No framework default icon left in the browser tab?
- Loading states shaped like the content instead of spinners, no layout jump on swap?

If a single point cannot be honestly ticked, the page is not done. Every point above applies to a
single page as much as to a site: scope changes how often the check runs, never whether it does.

**Across pages, once the scope is more than one:** run the eight points from section 1.2 against the
built templates rather than against the plan.

---

### 11.1 The contrast pass

**A separate pass, run on the built page, and not finished until every text on it has been measured.**
The declaration proved the palette can clear the numbers; it says nothing about what the page
renders, because opacity, translucency, inherited colour, a token reused on the wrong surface and a
blurred bar all move the value afterwards.

**Measure what renders, not what was designed.** A muted token that cleared 4.5:1 on white does not
clear it on the tinted section. `rgba(…, 0.6)` is not the colour in the palette. A label on a
translucent sticky bar is sitting on whatever happens to scroll behind it. Read the computed values
off the rendered page.

**Enumerate the pairings.** Every distinct combination of text and the surface it actually sits on.
These are the ones that get missed, and they are where the failures are:

- placeholder text, helper text and character counters in forms;
- disabled labels, disabled buttons and read-only fields;
- footer small print on the closing surface, which is the single most common failure on the page;
- links inside body copy, and their hover and visited states;
- the label on the accent fill, at the size it is actually set;
- the navigation in its translucent state, over the busiest thing that passes behind it;
- badges, pills, tags, counters, cart and step indicators;
- error, success and warning messages, including on tinted alert surfaces;
- captions, image credits, section labels and eyebrows set small in a quiet tone;
- text over photography and video, at its worst region, and again at the mobile crop;
- icons that are the only label, and focus rings against both the element and the surface behind it;
- any section that inverts to a dark surface, where every one of the above has to be re-measured.

**The thresholds are the ones in section 3**: 4.5:1 for body and anything under 24 px, 3:1 for large
text and for interface boundaries that carry meaning.

For the flat cases the enumeration can be done in a few seconds. Run this in the console of the built
page, once at desktop width and once at 390 px:

```js
const s=c=>{c/=255;return c<=.03928?c/12.92:((c+.055)/1.055)**2.4};
const lum=([r,g,b])=>.2126*s(r)+.7152*s(g)+.0722*s(b);
const rgb=v=>v.match(/[\d.]+/g).slice(0,3).map(Number);
const bg=el=>{for(let n=el;n;n=n.parentElement){const c=getComputedStyle(n).backgroundColor;
  if(c&&c!=='rgba(0, 0, 0, 0)'&&c!=='transparent')return rgb(c)}return[255,255,255]};
[...document.querySelectorAll('body *')].filter(e=>!e.children.length&&e.textContent.trim())
 .forEach(e=>{const c=getComputedStyle(e),a=lum(rgb(c.color)),b=lum(bg(e));
  const r=(Math.max(a,b)+.05)/(Math.min(a,b)+.05),px=parseFloat(c.fontSize);
  const big=px>=24||(px>=19&&parseInt(c.fontWeight)>=700);
  if(r<(big?3:4.5))console.warn(r.toFixed(2),px+'px',c.color,'|',e.textContent.trim().slice(0,45),e)});
```

It catches flat colour on flat surfaces, which is most of the page. What it cannot see is text over
images, gradients, video and blurred surfaces, and text whose own colour carries alpha, those are
measured by hand against the worst region they cross, on the rendered page, at both widths.

**A failure is fixed in the system, not on the element.** Darkening one caption leaves the same token
failing in nine other places. Move the value in the palette, then re-run the pass. And the value moves
only as far as the number requires: the rule from section 3 stands, a palette that cannot hit these
numbers is the wrong palette, but a brand colour that can hit them is not adjusted further for taste.

**The quiet tones are where it breaks.** Secondary text, metadata, legal lines, captions and
placeholders are exactly the elements a page dims to look calm, and exactly the ones that stop being
readable when it does. Calm comes from size, weight and space. It does not come from grey.

The pass is complete when every pairing above has been measured on the built page, not when the page
looks fine.

