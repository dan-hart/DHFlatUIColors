# Palette explorer implementation plan

**Goal:** Publish an interactive GitHub Pages SDK explorer using the package's actual colors, #FF6600 accents, and self-hosted Atkinson Hyperlegible.

**Design:** A light editorial workbench with warm neutral surfaces, palette navigation, generous swatches, and a selected-color inspector. Phone layouts retain all controls with a palette selector and stacked inspector. Swift developers can browse, search, inspect contrast, and copy preferred SDK accessors.

- [x] Export all Swift palettes with preferred member IDs, legacy search names, release status, and source order; reject unsupported source syntax.
- [x] Implement responsive browsing, search, selection, deep links, clipboard feedback, light/dark sample UI, and accurate contrast readings.
- [x] Self-host original Atkinson Hyperlegible regular and bold with the upstream license.
- [x] Validate the model, exporter, browser interactions, mobile widths, failure handling, and all 289 generated Swift accessors.
- [x] Complete independent review and accessibility checks.
- [ ] Privacy-scan and publish to GitHub Pages through a tested Actions workflow; verify the live deployment.

**Deployment boundary:** Publish only the static site artifact. Keep tests, SDK source, and local tooling out of the artifact. Actions use pinned revisions and only the deploy job receives Pages write and OIDC permissions. A website deployment does not create a new SDK release; Simple remains explicitly unreleased.
