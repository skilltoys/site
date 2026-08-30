#!/usr/bin/env bash
# Skapar ett skelett för ett nytt nyhetsinlägg.
# Användning: ./scripts/nytt-inlagg.sh min-slug "Min rubrik"
set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Användning: $0 <slug> \"<Rubrik>\"" >&2
  exit 1
fi

SLUG="$1"
TITLE="$2"
DATE="$(date +%Y-%m-%d)"
DATE_HUMAN="$(LC_TIME=sv_SE.UTF-8 date '+%-d %b %Y' 2>/dev/null || date '+%d %b %Y')"
DIR="$(cd "$(dirname "$0")/.." && pwd)/nyheter/${SLUG}"

if [ -e "$DIR" ]; then
  echo "Fel: ${DIR} finns redan." >&2
  exit 1
fi

mkdir -p "$DIR"
cat > "${DIR}/index.html" <<EOF
<!DOCTYPE html>
<html lang="sv">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${TITLE} | Skilltoys.se</title>
  <meta name="description" content="TODO: 140-155 tecken som sammanfattar inlägget.">
  <link rel="canonical" href="https://skilltoys.se/nyheter/${SLUG}/">
  <meta property="og:type" content="article">
  <meta property="og:site_name" content="Skilltoys.se">
  <meta property="og:title" content="${TITLE}">
  <meta property="og:description" content="TODO: samma som meta description.">
  <meta property="og:url" content="https://skilltoys.se/nyheter/${SLUG}/">
  <meta property="og:locale" content="sv_SE">
  <link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ccircle cx='50' cy='50' r='42' fill='%23e03e1f' stroke='%23171310' stroke-width='6'/%3E%3C/svg%3E">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:wght@400;700;800&family=Instrument+Sans:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/css/style.css">
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "NewsArticle",
    "headline": "${TITLE}",
    "description": "TODO",
    "inLanguage": "sv-SE",
    "datePublished": "${DATE}",
    "dateModified": "${DATE}",
    "author": { "@type": "Organization", "name": "Skilltoys.se" },
    "publisher": { "@id": "https://skilltoys.se/#organization" },
    "mainEntityOfPage": "https://skilltoys.se/nyheter/${SLUG}/"
  }
  </script>
</head>
<body>
  <a class="skip-link" href="#main">Hoppa till innehållet</a>

  <header class="site-header">
    <div class="site-header__inner">
      <a class="logo" href="/"><span class="logo__dot"></span>SKILLTOYS.SE</a>
      <nav class="site-nav" aria-label="Huvudmeny">
        <a href="/guider/">Guider</a>
        <a href="/nyheter/" class="is-active">Nyheter</a>
        <a href="/om/">Om sajten</a>
      </nav>
    </div>
  </header>

  <main id="main">
    <article class="article">
      <nav class="breadcrumb" aria-label="Brödsmulor">
        <ol>
          <li><a href="/">Hem</a></li>
          <li><a href="/nyheter/">Nyheter</a></li>
          <li aria-current="page">${TITLE}</li>
        </ol>
      </nav>

      <span class="kicker">Nyheter</span>
      <h1>${TITLE}</h1>
      <div class="article__meta">
        <span>Publicerad ${DATE_HUMAN}</span>
      </div>

      <p>TODO: skriv inlägget här.</p>
    </article>
  </main>

  <footer class="site-footer">
    <div class="site-footer__legal">© 2026 Skilltoys.se · Kendama, yoyo &amp; begleri för Sverige</div>
  </footer>
</body>
</html>
EOF

echo "Skapade ${DIR}/index.html"
echo "Glöm inte att:"
echo "  1. Skriva klart innehållet (sök på TODO)"
echo "  2. Lägga till inlägget i nyheter/index.html och startsidans lista"
echo "  3. Lägga till URL:en i sitemap.xml med <lastmod>${DATE}</lastmod>"
