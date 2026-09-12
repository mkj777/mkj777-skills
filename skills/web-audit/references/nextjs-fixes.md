# Lighthouse-Audit zu Fix, Next.js zuerst

Die Tabelle bildet Lighthouse-Audit-IDs (Spalte `Audit` in `summary.md`) auf den Fix ab, der bei
Next.js mit App Router fast immer der richtige ist. Sie ersetzt das Raten. Steht der Fix hier,
wird er so umgesetzt; steht er nicht hier, wird der Audit-Text von Lighthouse gelesen und der Fix
begründet.

Framework erkennen: `package.json` mit `next` im Repo, oder im Browser
`evaluate_script` mit `!!document.querySelector('script[src*="/_next/"]') || !!window.__NEXT_DATA__`.

## LCP

| Audit-ID | Fix in Next.js |
|---|---|
| `largest-contentful-paint-element`, `prioritize-lcp-image`, `lcp-lazy-loaded` | Hero-Bild über `next/image` mit `priority` (setzt `fetchpriority="high"` und Preload). Kein `loading="lazy"` above the fold. `sizes` passend zum Layout (`(max-width: 768px) 100vw, 50vw`), sonst lädt Mobile die Desktop-Datei. |
| `uses-responsive-images`, `modern-image-formats`, `uses-optimized-images`, `efficient-animated-content` | Alle `<img>` durch `next/image` ersetzen (liefert AVIF/WebP und Größenvarianten). Remote-Bilder in `next.config` unter `images.remotePatterns` freigeben. Animierte GIFs als `<video muted autoplay loop playsinline>`. |
| `unsized-images` | `width` und `height` setzen oder `fill` mit einem Container, der `position: relative` und feste Höhe oder `aspect-ratio` hat. |
| `render-blocking-resources` (CSS) | Bei App Router ist CSS pro Route gesplittet; große globale Stylesheets in Layout-nahe CSS-Module aufteilen. Tailwind: `content`-Pfade prüfen, damit nichts Ungenutztes im Bundle bleibt. Externe CSS-Links (Icon-Fonts, Widgets) entfernen oder inline laden. |
| `render-blocking-resources` (Fonts), `font-display` | `next/font/google` oder `next/font/local` mit `subsets: ['latin']` und `display: 'swap'`. Keine `<link>` auf `fonts.googleapis.com`. Höchstens zwei Schnitte pro Familie laden. |
| `server-response-time` | Route statisch machen oder `export const revalidate = <s>` (ISR). Datenquellen cachen (`fetch` mit `next: { revalidate }`, `unstable_cache`). Bei Vercel-Cold-Starts: Variabilität im Report nennen, `measure.mjs` mit Warm-up läuft dagegen an. |
| `uses-rel-preconnect` | `<link rel="preconnect">` für die eine oder zwei Drittdomains, die im kritischen Pfad liegen, im Root-Layout. Nicht für alles. |
| `uses-text-compression` | Vercel komprimiert selbst. Bei eigenem Hosting Reverse-Proxy (Brotli/gzip) prüfen. |

## TBT und Interaktivität

| Audit-ID | Fix in Next.js |
|---|---|
| `total-blocking-time`, `mainthread-work-breakdown`, `bootup-time` | Komponenten ohne Interaktion als Server Components lassen (kein `"use client"` am Layout oder an ganzen Seiten). `"use client"` nur an das Blatt, das wirklich Events oder State hat. |
| `unused-javascript` | `@next/bundle-analyzer` laufen lassen (`ANALYZE=true next build`). Schwere Client-Bibliotheken (Charts, Editoren, Karten, Datepicker) mit `next/dynamic` und `ssr: false` laden, erst bei Sichtbarkeit oder Interaktion. Lodash-artige Utilities durch native Methoden ersetzen. `date-fns`/`dayjs` statt `moment`. |
| `third-party-summary`, `third-party-facades` | Tracking, Chat-Widgets, Consent-Banner über `next/script` mit `strategy="lazyOnload"` (nach Load) oder `"afterInteractive"`. YouTube und Maps hinter eine Facade (Vorschaubild plus Klick). Google Tag Manager nur, wenn wirklich genutzt. |
| `dom-size` | Listen paginieren oder virtualisieren. Versteckte Menüs und Modals nicht als riesige DOM-Bäume vorhalten, sondern bei Bedarf rendern. |
| `long-tasks` | Ursache aus `performance_analyze_insight` (LongCriticalNetworkTree, RenderBlocking) lesen. Meist derselbe Fix wie `unused-javascript`. |
| `legacy-javascript` | `browserslist` in `package.json` auf aktuelle Browser setzen; Next liefert dann keine Polyfills mehr, die niemand braucht. |

## CLS

| Audit-ID | Fix in Next.js |
|---|---|
| `cumulative-layout-shift`, `layout-shift-elements` | Elemente, die Lighthouse nennt, bekommen feste Maße: Bilder über `next/image` mit Größe, Embeds in Container mit `aspect-ratio`, Banner und Toasts mit reserviertem Platz oder `position: fixed`. |
| `non-composited-animations` | Nur `transform` und `opacity` animieren, nicht `top`, `height`, `margin`. |
| Font-bedingte Shifts (im `layout-shift-elements`-Detail als Text-Knoten) | `next/font` mit `adjustFontFallback: true` (Standard), Fallback-Metriken werden dann angepasst. |

## Caching und Auslieferung

| Audit-ID | Fix in Next.js |
|---|---|
| `uses-long-cache-ttl` | `/_next/static` ist bereits unveränderlich gecacht. Für `public/`-Assets `headers()` in `next.config` mit `Cache-Control: public, max-age=31536000, immutable`, Dateinamen dann mit Hash. |
| `total-byte-weight` | Folgt aus den Bild- und JS-Fixes oben. Große JSON-Payloads in Server Components verarbeiten statt an den Client schicken. |
| `redirects` | Redirect-Ketten in `next.config` `redirects()` auf einen Sprung kürzen. `www` und `http` auf Hosting-Ebene (Vercel-Domain-Einstellung) auflösen. |
| `uses-http2` | Vercel liefert HTTP/2. Bei eigenem Hosting Proxy-Konfiguration. |

## A11y, SEO, Best Practices (Lighthouse-Teil)

| Audit-ID | Fix |
|---|---|
| `color-contrast` | Tokens in `globals.css` anpassen, nicht einzelne Stellen. Mindestens 4.5:1 für Fließtext, 3:1 für großen Text und UI-Rahmen. |
| `image-alt`, `link-name`, `button-name` | Siehe `a11y-checklist.md` Abschnitte 2 und 3; hier nur die syntaktische Seite. |
| `heading-order` | Siehe `a11y-checklist.md` Abschnitt 1. |
| `html-has-lang`, `html-lang-valid` | `<html lang="de">` im Root-Layout. |
| `meta-viewport` | Next setzt es über die `viewport`-Export im Root-Layout. Nicht `user-scalable=no`. |
| `document-title`, `meta-description` | `metadata`-Export pro Seite (`title`, `description`), `title.template` im Root-Layout. |
| `tap-targets`, `target-size` | Mindestens 24 mal 24 CSS-Pixel, bei Nav-Links Padding statt Font-Size erhöhen. |
| `is-crawlable` | `robots`-Metadata prüfen. Bei Demo-Seiten ist `noindex` gewollt und kein Finding. |
| `errors-in-console` | `list_console_messages` lesen, Ursache beheben, nicht unterdrücken. Hydration-Fehler sind hier häufig und ein echtes Problem. |
| `deprecations`, `third-party-cookies` | Meist aus Drittskripten; siehe `third-party-summary`. |

## Andere Frameworks

Gleiche Audits, andere Werkzeuge:

| Thema | Astro | Vite/React SPA | Statisches HTML |
|---|---|---|---|
| Bilder | `<Image>` aus `astro:assets`, `loading="eager"` für den Hero | `vite-imagetools` oder Build-Schritt mit `sharp`; `<picture>` mit AVIF/WebP | vorab konvertieren, `<picture>`, `width`/`height` |
| Fonts | `@fontsource`-Pakete oder lokale WOFF2 mit `font-display: swap`, Preload für den Hauptschnitt | dito | dito |
| JS reduzieren | Islands: `client:visible` statt `client:load` | `React.lazy` plus `Suspense`, Route-Splitting, `rollup-plugin-visualizer` | Skripte `defer`, nur was gebraucht wird |
| Drittskripte | `<script>` mit `is:inline` und `defer` oder Partytown | `async`/`defer`, Facades | dito |
| Caching | Hosting-Header | Hosting-Header, gehashte Dateinamen kommen aus Vite | Hosting-Header |
| Server-Antwort | Prerender statt SSR wo möglich | SPA ist statisch; TTFB ist Hosting | Hosting |
