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

## Deploy (välj en, alla gratis)

- **Cloudflare Pages** (rekommenderas): koppla git-repot, inga bygginställningar behövs, peka `skilltoys.se` på projektet.
- **Netlify**: samma sak — drag & drop eller git-koppling.
- **GitHub Pages**: pusha till GitHub, aktivera Pages, lägg CNAME för domänen.

## Checklista för SEO-effekt (utan detta händer inget)

1. [ ] Registrera **skilltoys.se** och peka domänen på hostingen.
2. [ ] Verifiera sajten i **Google Search Console** och skicka in `sitemap.xml`.
3. [ ] Verifiera även i **Bing Webmaster Tools** (billig extratrafik).
4. [ ] Publicera 1–2 nya inlägg eller guider **per månad** — regelbundenhet slår volym.
5. [ ] Skaffa några inlänkar: svenska hobbyforum, Facebook-grupper för kendama/yoyo,
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
