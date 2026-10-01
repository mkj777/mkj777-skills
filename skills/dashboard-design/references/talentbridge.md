# Project profile: TalentBridge

MyTalentBridge, a brand of BMP Agency GmbH. Job portal and staffing service (hospitality,
events, logistics). Two logged-in areas, each with a dark sidebar shell:

| Area | Who | Role card question | Navigation |
|---|---|---|---|
| **Kundenbereich** | Applicants. They are the paying customers here (counselling appointments, subscriptions, invoices). | "Can I apply, and where do my applications stand?" | Übersicht, Jobportal, Meine Bewerbungen, Termine, Profil & Lebenslauf, Rechnungen, Einstellungen |
| **Backoffice** (`/backoffice`) | Vermittler (placement staff), per team and location | "Which applications, appointments and cancellations are waiting for me?" | Bewerbungen, Stellen, Termine, Kündigungen, Bewerberdatenbank, Bestandskunden, Einstellungen |

Company clients booking staff (`/personalbuchung`) are a public request flow, not a
logged-in area so far. "Bestandskunden" in the back office has not been reviewed yet.

Tokens below are taken from the compiled CSS of the staging deployment
(`talentbridgestaging.vercel.app`, October 2026). Stack: Next.js, Tailwind v4, shadcn/ui
variables. When the repository is available, its `globals.css` is the source of truth and
this file is updated from it.

## Type

| Token | Value | Use |
|---|---|---|
| `--font-sans` | Manrope | everything |
| `--font-mono` | JetBrains Mono | IDs, codes, eyebrows, numbers in tables if not tabular |

Sizes are the Tailwind defaults (`text-xs` 12 px to `text-5xl` 48 px). Weights 400 to 800.

## Colour

Brand:

| Token | Value |
|---|---|
| `--brand-50` | `#f1fbf4` |
| `--brand-100` | `#dff4e4` |
| `--brand-300` | `#8ae075` |
| `--brand-500` | `#0b995a` |
| `--brand-600` | `#0b6f42` (`--primary`) |
| `--brand-700` | `#06301c` |
| `--brand-gradient` | `linear-gradient(180deg, #6ad359, #0b995a)` |

Neutral:

| Token | Value |
|---|---|
| `--neutral-0` | `#fff` (background, card) |
| `--neutral-50` | `#f6f7f5` (muted, app background) |
| `--neutral-100` | `#eceeea` |
| `--neutral-200` | `#dcdfda` |
| `--neutral-400` | `#9aa5a0` |
| `--neutral-500` | `#8b9691` |
| `--neutral-600` | `#5b6863` (muted text) |
| `--neutral-700` | `#3d4a44` |
| `--neutral-900` | `#0f1512` (foreground, dark sidebar) |
| `--border` | `#0f15121a` |
| `--input` | `#0f151229` |

Status:

| Tone | Text | Background | Line |
|---|---|---|---|
| ok | `--status-ok` = brand 600 | `#6ad35929` | `#0b995a40` |
| warn | `#8b6b1f` | `#d6a62c29` | `#d6a62c66` |
| info | `#1f5b8b` | `#2c82d624` | missing |
| danger | `#8b3b3b` | `#be46461f` | missing |
| offen | `#f2a33a` | missing | missing |

Radius: `--radius` 10 px, `--radius-md` 8 px, `--radius-sm` 6 px.

## Token gaps to close

1. **`--status-offen` has no background and line**, and `#f2a33a` as text fails contrast on
   white. Either map "offen" to `warn` or add `--status-offen-text` (dark), `-bg`, `-line`.
2. **`--status-info-line` and `--status-danger-line` are missing**; pills cannot be built
   uniformly.
3. **`--chart-1` to `--chart-5` are the shadcn greys.** Set `--chart-1` to brand 500 and
   derive the rest from the `dataviz` skill, or charts will ignore the brand.
4. **`--sidebar-*` are shadcn defaults** (light grey) while the app sidebar is dark
   `neutral-900`. Either the tokens are unused (remove) or the sidebar is hard coded (fix).
5. **No decided primary button.** See S1 below.

## Shell findings (both areas)

| # | Rule | Where | What the user experiences | Fix |
|---|---|---|---|---|
| S1 | 3 | everywhere | The primary button is black on some pages ("Stelle anlegen", "Termin anfragen", "Jobs durchsuchen") and a green gradient on others ("Passwort ändern", "Speichern", "Termin anfragen" on the overview card). The user cannot learn what the main button looks like. | One primary: brand 600 solid. No gradient on buttons. Black only for dark surfaces. |
| S2 | 6 | sidebar, both areas | "Abmelden" is a text link next to the user name; language is text plus globe. | Log out as an icon button (door icon, `aria-label="Abmelden"`, tooltip). Language as icon button with the code. |
| S3 | shell | Termine (both), Bewerberdatenbank | Subtext runs to two or three lines explaining how the feature works (blocked accounts, calendar files, video link, price). | One line of scope. The explanation moves into the dialog of the action it explains ("Sperren" confirm, "Termin bestätigen" dialog). |
| S4 | shell | Termine (both) | Empty state is a dashed box, while other pages use solid cards. | Same card as every other page, empty state inside it. |
| S5 | shell | Einstellungen, Kundenbereich Termine | Card width differs from page to page (Einstellungen narrower than the tables; divider and accordion on Termine narrower than the header). | One content width from the shell. Forms may limit their field width inside the card, not the card. |
| S6 | shell | Bewerbungen, Stellen, Bewerberdatenbank | Search and filter chips float between header and card. | Toolbar inside the top of the card. |
| S7 | never built | everywhere | Test data in every screen ("Test 3009 Pruefer v16", "Stelle 1", "weqwqe"). Layout is judged against wrong lengths. | Realistic seed data on staging. |

## Kundenbereich findings

Reviewed on screenshots of Übersicht, Jobportal, Meine Bewerbungen, Termine, Profil &
Lebenslauf, logged in as an applicant with a 29 % profile.

What already works and stays:

- Dark sidebar, light neutral work surface, white cards: calm and clearly zoned.
- Readiness checklist with "4 fehlen" per section and one action per row.
- Section badges "4 FEHLEN" in warn tone, missing required fields tinted warn before submit
  (rule 19 done right).
- Empty state on Meine Bewerbungen with reason and "Zum Jobportal" action.
- Title as data on the job portal ("13 offene Stellen").

| # | Rule | Where | What the user experiences | Fix |
|---|---|---|---|---|
| K1 | 2 | Übersicht | Primary action is "Jobs durchsuchen" although the user cannot apply yet. They browse, pick a job, and hit a wall. | Primary "Profil vervollständigen" while incomplete; switch to "Jobs durchsuchen" when complete. |
| K2 | 8 | Übersicht, all pages | Profile progress appears three times: sidebar card (29 %, 10 Pflichtangaben), checklist header (10 Angaben), orange dot in navigation. | Checklist is the source. Sidebar card becomes one compact line linking to it; keep or drop the dot, not both. |
| K3 | 31 | Übersicht | "Hallo weqwqe, Schön, dass du da bist." takes the first line and says nothing. | "Noch 10 Angaben bis zur ersten Bewerbung" as title, the name in the sidebar is enough. |
| K4 | 26, 24 | Übersicht | "Meine Bewerbungen" and "Für dich empfohlen" are two full empty cards. "Zurzeit keine passenden Vorschläge" does not say that the incomplete profile is the reason. | While blocked: one line naming the blocker. Show the sections once there is content. |
| K5 | 1, 18 | Übersicht | The dark counselling card with its own green button competes with the checklist and the top button. Three emphasis points. | Counselling as a secondary row or a quiet card without a filled button. |
| K6 | 9 | Jobportal | "Stelle 1" shows "ab sofort" in the slot where all others show the wage. | Fixed slot meaning; "Lohn auf Anfrage" when missing. |
| K7 | 10, 21 | Jobportal | Location and employment type are small green mono capitals, wage is muted grey; the two things applicants decide on are the weakest text. Two column cards with lots of air make 13+ jobs slow to scan. | Job row pattern from patterns.md: title, wage and type at body size, location with distance, state relative to the person. |
| K8 | 2, 26 | Jobportal, Meine Bewerbungen | Nothing tells the applicant they cannot apply yet. "Zum Jobportal" sends them to jobs they cannot apply to. | Hint on the job portal while blocked, and the empty state names the blocker with "Profil vervollständigen". |
| K9 | 30, 8 | Termine | Marketing paragraph, the price stated three times (paragraph, note, overview card), an accordion of topics from the public page. | One sentence plus price once next to the button. Topics go behind "Mehr erfahren" or into the request form as a topic select. |
| K10 | 26 | Termine | "Noch keine Anfrage gestellt." without action next to it. | "Termin anfragen" inside the empty state. |
| K11 | 5 | Profil | The floating green "Speichern" covers the "Hochladen" action of Profilfoto. | Sticky save bar with reserved bottom padding and visible save state. |
| K12 | 9 | Profil | "optional" only as placeholder on Geburtsname and Telefon disappears on typing. | "optional" in the label. |
| K13 | patterns: form | Profil | Twelve status chips for a single choice wrap over three lines. | Select or radio list for more than six options. |

## Backoffice findings (Vermittler)

Reviewed on screenshots of Bewerbungen, Stellen, Bewerberdatenbank, Termine (Terminanfragen),
Einstellungen, logged in as a Vermittler of team München.

What already works and stays:

- Real tables with mono dates, sortable columns on Stellen, filter chips per status.
- Subtext on Bewerbungen states the scope ("Alle Standorte, letzte 30 Tage"): exactly what
  subtext is for.
- Status vocabulary partly right: "Zurückgezogen" neutral, "Eingegangen" info, "CV FEHLT" warn
  with icon and word.
- Applicant count on Stellen is a link when above zero.

| # | Rule | Where | What the user experiences | Fix |
|---|---|---|---|---|
| B1 | 13 | Bewerbungen | "Aktive Abos 3" sits on the applications page; none of the three tiles opens anything. "nächste 7 Tage" is green although it is a period, not a good trend. | Tiles go. Counts move into the filter chips ("Eingegangen 1"). Abos belong on Kündigungen. Green only for positive change. |
| B2 | 13, 8 | Bewerberdatenbank | Four tiles (25, 11, 0, 4) count exactly what the chips below filter (Alle, Neu, Gesperrt, Unbestätigt). | Drop the tiles, put the counts on the chips. |
| B3 | 7 | Stellen | Every row carries two stacked buttons "Duplizieren" and "Schließen"; rows grow to about 115 px, 6 jobs per screen. "Schließen" is destructive and sits inline. | Row end: one "more" icon button with Duplizieren, Bearbeiten, Schließen (with confirm). Row click opens the panel. |
| B4 | 7, 30 | Bewerberdatenbank | "Sperren" is an inline text action under the status in every row. The consequences are explained in the page subtext instead of where the click happens. | "Sperren" in the overflow menu and panel, confirm dialog states the consequences (logged out, no login, no jobs, no job mails). |
| B5 | 14 | Bewerberdatenbank | Status column shows "Aktiv" in every row, Herkunft shows a dash in every row. | Status shows only exceptions (Gesperrt, Unbestätigt). Herkunft hidden until it has data. |
| B6 | 15, 32 | Bewerberdatenbank | Emails wrap mid-word ("mytalentb / ridge.de"); date, time and last login stack into three lines; rows about 110 px. | Email one line with ellipsis. Registered date one line, "zuletzt aktiv" as muted meta line or panel. |
| B7 | 32 | Stellen | URL slug in mono under every title ("/jobs/Otto-Perutz-Str.", including a street address as slug). Nobody acts on it in the list. | Slug moves to the panel and the edit form. |
| B8 | 14 | Stellen | "0 Bewerbungen" repeats the word in a column titled Bewerber; "Ende" shows a dash for open ended jobs. | Number only, right aligned, 0 muted. "unbefristet" instead of a dash. |
| B9 | 19, status vocabulary | Stellen | "Abgelaufen" is red. An expired job is a normal end of life, nothing went wrong. | Neutral pill, row muted. Warn tone for "läuft in 2 Tagen ab" so the Vermittler can act before it expires. |
| B10 | 7, 9 | Bewerbungen | Personalberater shows a dash in every row; Kontakt is a column holding only an envelope icon; Ort shows a dash. | Unassigned is a state with an action ("Zuweisen"). Contact goes into the row hover and the panel. Missing Ort reads "nicht angegeben". |
| B11 | 20 | Bewerbungen | Withdrawn applications look like active ones; only the pill differs. | Whole row muted for Zurückgezogen and Abgesagt. Default view hides them behind the filter. |
| B12 | 22 | Bewerbungen, Stellen | Default sort is by date, newest first. The Vermittler needs the oldest unhandled application first. | Default "Eingegangen", oldest first. Navigation shows counts of open items ("Bewerbungen 1", "Termine 0"). |
| B13 | role overview | Backoffice | There is no landing view; the Vermittler starts in Bewerbungen and has to visit Termine and Kündigungen to see if anything waits there. | Work queue as the first view (patterns.md, back office overview) or counts in the navigation as the minimum. |

## Open

- Bestandskunden and Kündigungen (back office), Rechnungen and Einstellungen (Kundenbereich):
  not reviewed yet.
- Mobile: all findings above are desktop; check the Kundenbereich at 360 px first.
