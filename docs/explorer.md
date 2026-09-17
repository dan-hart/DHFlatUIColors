# Color explorer

The GitHub Pages site lives in `site/`. It is static HTML, CSS, and JavaScript with no runtime dependencies. Atkinson Hyperlegible regular and bold are self-hosted; their original [SIL Open Font License](../site/fonts/OFL.txt) is included. Font files come from [Google Fonts' Atkinson Hyperlegible repository](https://github.com/googlefonts/atkinson-hyperlegible/tree/main/fonts/webfonts).

## Palette data

Swift source is the source of truth. After a palette change, run:

```sh
python3 -B scripts/export-palettes.py
```

Commit the updated `site/palettes.json` alongside the Swift changes. The exporter preserves SDK iteration order, resolves deprecated member spellings to preferred aliases, and rejects unsupported syntax rather than silently dropping values. Its explicit release sets distinguish 1.0.0 palettes from the unreleased Simple palette.

When publishing another SDK release, update release metadata in the exporter and release/install messaging in `site/index.html` and `site/app.mjs`, then regenerate the data. A site deployment does not publish a Swift package release.

## Local preview and verification

```sh
npm ci
python3 -B -m unittest discover -s scripts -p 'test_*.py'
python3 -B scripts/export-palettes.py --check
npm test
npm run test:browser
```

Browser tests use installed Google Chrome locally. In CI, Playwright installs Chromium. The test configuration starts a local preview server automatically, or reuses one on port 8769. To browse manually:

```sh
python3 -m http.server 8769 --bind 127.0.0.1 --directory site
```

Open `http://127.0.0.1:8769/`. Palette/color/export-format selections can be shared through the URL hash. Search includes preferred names, previous names, hex values, and palettes. Contrast calculations use linearized sRGB and unrounded ratios for WCAG AA classifications. White ink is `#FFFFFF`; dark ink is `#171C1B`. The context preview intentionally lets users inspect low-contrast combinations and labels those results.

## Deployment

`.github/workflows/pages.yml` tests changes on pull requests and pushes to `main`. Only `main` deploys. It publishes an explicit static artifact after data, unit, and browser checks pass. Tests, tooling, and SDK files are excluded from the artifact. GitHub Pages must use **GitHub Actions** as its build source.

No analytics, external font requests, cookies, secrets, or backend are required. The site has only public repository and support links. The accent is `#FF6600`; text on light backgrounds uses darker ink where needed for readability.
