# Skilltoys.se — SEO-placeholder

Statisk placeholder-sajt för **skilltoys.se**, byggd för att börja samla SEO-värde
(indexering, domänålder, sökordsranking) inför en framtida e-handel (troligen Shopify).

**Stack:** ren HTML + CSS. Inget byggsteg, inga beroenden.

## Struktur

```
index.html                          Startsida (WebSite + Organization schema)
guider/                             Evergreen-guider (Article + Breadcrumb schema)
  vad-ar-skilltoys/                 + FAQPage schema
  kendama-for-nyborjare/
  yoyo-for-nyborjare/
  begleri-guide/
nyheter/                            Nyhetssektion (NewsArticle schema)
om/                                 Om sajten
css/style.css                       Hela designsystemet
sitemap.xml, robots.txt, 404.html
scripts/nytt-inlagg.sh              Skapar skelett för nytt nyhetsinlägg
```

Alla sidor är `mapp/index.html` → rena URL:er (`/guider/kendama-for-nyborjare/`)
som fungerar identiskt på alla statiska hostar och kan 301:as 1:1 till en
framtida Shopify-blogg.

## Lokal förhandsvisning

```bash
python3 -m http.server 8080
```

Öppna sedan http://localhost:8080 (absoluta sökvägar som `/css/style.css` kräver en server — öppna inte filerna direkt med `file://`).

## Deploy (aktuell setup)

Sajten deployas som en **Cloudflare Worker med static assets** (git-kopplad via
Workers Builds i Cloudflare-kontot "skilltoys"):

- Repo: https://github.com/skilltoys/site → varje push till `main` bygger
  och deployar automatiskt (`npx wrangler deploy`).
- Worker: `site` → https://site.skilltoys.workers.dev
- Konfiguration i `wrangler.jsonc` (clean URLs, 404-hantering);
  `.assetsignore` håller repo-filer utanför deployen; `_headers` sätter
  säkerhets- och cache-headers.
- OBS: `_redirects` för Workers assets tillåter bara relativa URL:er —
  www→apex-redirecten görs i stället som en **Redirect Rule** i zonen
  (Rules → Redirect Rules i Cloudflare-dashboarden).

## Checklista för SEO-effekt (utan detta händer inget)

1. [x] Domänen **skilltoys.se** ägd; zon tillagd i Cloudflare (NS-byte hos Loopia pågår).
2. [ ] Koppla `skilltoys.se` + `www` som custom domains på Workern när zonen är aktiv,
       och lägg Redirect Rule för www→apex.
3. [ ] Verifiera sajten i **Google Search Console** och skicka in `sitemap.xml`.
4. [ ] Verifiera även i **Bing Webmaster Tools** (billig extratrafik).
5. [ ] Publicera 1–2 nya inlägg eller guider **per månad** — regelbundenhet slår volym.
6. [ ] Skaffa några inlänkar: svenska hobbyforum, Facebook-grupper för kendama/yoyo,
       länk från eventuella andra egna sajter.

## Nytt nyhetsinlägg

```bash
./scripts/nytt-inlagg.sh min-rubrik-som-slug "Min rubrik"
```

Skapar `nyheter/min-rubrik-som-slug/index.html` från en mall. Skriv innehållet,
lägg till inlägget i `nyheter/index.html`, startsidans lista och `sitemap.xml`.

### Om AI-genererade nyheter

Skalad, automatiskt genererad text utan eget värde klassas av Google som
**scaled content abuse** (spampolicyn, uppdaterad 2024) och kan sänka hela
domänen — särskilt en ny domän utan förtroende. Använd AI som skrivhjälp,
men håll volymen låg, kvaliteten hög och innehållet sant. Ett bra inlägg i
månaden bygger domänen; trettio tunna inlägg i veckan riskerar den.

## Vid Shopify-migrering

1. Skapa motsvarande innehåll som Shopify-sidor/blogginlägg.
2. Sätt 301-redirects från dessa URL:er till de nya (Shopifys URL Redirects).
3. Behåll title/meta descriptions — de har då upparbetad ranking.
