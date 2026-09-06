# cryptozing-site

The CryptoZing content site (cryptozing.app articles), split out of the app repo in MS20 Phase 2 — **not** the Laravel app.

- Do not pull Laravel routes, Blade components, app config, or `vendor/` references into files here.
- Authoring is plain HTML / Markdown; `_layouts/` and `learn/` follow the Eleventy build (`npx @11ty/eleventy`, output in `_site/`).
- Staging copy under `staging/` should be edited before the published copy (see memory: "Update Staging Copy First").
- Publishing: `container.yml` builds the nginx image on push to `main`; `scripts/publish-vps.sh <sha>` rolls the production box onto it and notifies IndexNow once the public sitemap matches. Rollback is the same command with the previous sha. `pages.yml` still deploys to GitHub Pages, but Pages is no longer the DNS target; it stays only as a recovery path and no longer notifies IndexNow.
