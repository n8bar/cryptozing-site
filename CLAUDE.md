# cryptozing-site

The CryptoZing content site (cryptozing.app articles), split out of the app repo in MS20 Phase 2 — **not** the Laravel app.

- Do not pull Laravel routes, Blade components, app config, or `vendor/` references into files here.
- Authoring is plain HTML / Markdown; `_layouts/` and `learn/` follow the Eleventy build (`npx @11ty/eleventy`, output in `_site/`).
- Staging copy under `staging/` should be edited before the published copy (see memory: "Update Staging Copy First").
- Publishing: GitHub Pages deploys from the `pages.yml` workflow on push to `main` (until MS21 retires Pages); `container.yml` publishes the nginx image to GHCR for the production box.
