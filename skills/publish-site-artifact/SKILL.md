---
name: publish-site-artifact
description: Publish a static site artifact — a self-contained report or guide page — to the static-site dumpyard. Use when asked to publish, upload, or add a static page artifact.
---

# Publish to sites.ram.net.co

Static-site dumpyard by Ramesh Sharma. Repo `ramesharma/sites.ram.net.co`, branch `main`, served from root at https://sites.ram.net.co.

## Design System

**All new pages MUST use the shared design system.** The design system lives at `/design-system/main.css` and provides:

- **Tokens** (`/design-system/tokens.css`): colors, typography, spacing, radius, motion
- **Base** (`/design-system/base.css`): reset, typography, links, selection
- **Components** (`/design-system/components.css`): container, section, eyebrow, hero, prose, listing, link-list, footer, responsive

**To use in your page:**
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/design-system/main.css">
```

**Key classes to use:**
- `.container` — max-width 720px, centered
- `.section` — vertical rhythm, hairline border
- `.eyebrow` — uppercase mono section labels
- `.container` + `.listing` + `.listing__item` + `.listing__link` + `.listing__meta` — for listing pages
- `.prose p` — for prose content
- `.footer` — standard footer
- `.footer p` — mono, dim text

**Fonts:** Inter (sans) + JetBrains Mono (mono). Load from Google Fonts as shown above.

**Do NOT write inline CSS.** Use the design system classes. If you need a one-off override, add a minimal `<style>` block at the top of your page — but prefer extending the design system instead.

---

## Add a page

1. Slug: lowercase kebab-case, e.g. `indian-railways-history`.
2. Write `index.html` using the design system (see template below) to:
   - report → `research/<slug>/index.html` (serves at `/research/<slug>/`)
   - guide → `learning/<slug>/index.html` (serves at `/learning/<slug>/`)
3. Never touch `CNAME`, `.nojekyll`, `robots.txt`, `llms.txt`, `add-skill.sh`, `skills/`, `research/index.html`, `learning/index.html` (listings regenerate automatically via a GitHub Action). Never commit tokens/secrets.

### Page template

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Page Title — sites.ram.net.co</title>
  <meta name="description" content="One-sentence description.">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/design-system/main.css">
  <style>
    /* Minimal site-specific overrides only */
  </style>
</head>
<body>
  <header class="hero">
    <div class="container">
      <div class="hero__monogram">[ RS ]</div>
      <h1 class="hero__name">Page Title</h1>
      <p class="hero__tagline">One-sentence description of what this page is.</p>
    </div>
  </header>

  <main>
    <section class="section">
      <div class="container">
        <h2 class="section__heading"><span class="eyebrow">Section Name</span></h2>
        <div class="prose">
          <p>Your content here.</p>
        </div>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="container">
      <p>No trackers. No frameworks. Just HTML.</p>
    </div>
  </footer>
</body>
</html>
```

---

## Upload (pick the first that applies; never hardcode or commit tokens)

### 1. gh CLI (shell, authenticated — no clone needed)

```sh
CONTENT=$(base64 < /local/path/to/index.html | tr -d '\n')
gh api "repos/ramesharma/sites.ram.net.co/contents/research/<slug>/index.html" \
  -X PUT -f message="add <slug>" -f branch="main" -f content="$CONTENT"
# updating an existing file: GET the path first for its "sha", then add -f sha="<sha>".
```
Ref: https://cli.github.com/manual/

### 2. GitHub MCP server (installed + authenticated)

Call `create_or_update_file` once per file with owner `ramesharma`,
repo `ram.net.co`, branch `main`, path `research/<slug>/index.html`
(or `learning/...`), your HTML as `content` (raw text, not base64),
message `add <slug>`. Omit `sha` for new files; for updates fetch it
first via `get_file_contents` (same owner/repo/path, ref `main`).
Ref: https://github.com/github/github-mcp-server

### 3. GitHub REST API (`GITHUB_TOKEN` in env, else ask the human for one)

```sh
CONTENT=$(base64 < /local/path/to/index.html | tr -d '\n')
curl -X PUT -H "Authorization: Bearer ***" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/ramesharma/sites.ram.net.co/contents/research/<slug>/index.html \
  -d "{\"message\":\"add <slug>\",\"content\":\"$CONTENT\",\"branch\":\"main\"}"
# updating an existing file: GET the path first, add its "sha" to the payload.
```
Ref: https://docs.github.com/en/rest/repos/contents#create-or-update-file-contents

---

## Checklist before you finish

- [ ] Page uses the shared design system (`/design-system/main.css`)
- [ ] Page renders standalone (open the file directly, no server needed)
- [ ] You pushed only your page (listings update themselves via Action)
- [ ] No secrets, tokens, or personal data committed
- [ ] Tell the human the public URL
