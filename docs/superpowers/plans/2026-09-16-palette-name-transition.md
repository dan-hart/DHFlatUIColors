# Palette Name Transition Implementation Plan

**Goal:** Adopt the approved 14 palette names and replace geographic color names, preserving all 280 hex values and their order.

**Architecture:** Rename palette types and files; retain deprecated type aliases. Preserve existing enum cases for exhaustive switch compatibility during the transition, with preferred names exposed as static properties. Display names and documentation use the preferred names. Explicit allCases lists avoid duplicate aliases and accommodate deprecated cases.

**Tech Stack:** Swift 5.9 package, SwiftUI, XCTest.

- [x] Inspect current source, record original values, run baseline tests (3 passed).
- [x] Add failing tests for display names and original ordered hex values.
- [x] Add new palette and color accessors and deprecated declarations with renamed fix-its.
- [x] Document every mapping and phased switch migration.
- [x] Test both old and new access, unique enumeration, and compile original exhaustive switches.
- [x] Run swift test and inspect the final diff; obtain an independent review.

**Validation:** Run `swift test --scratch-path /private/tmp/dhflatui-build`; typecheck an external client that uses every original enum case in exhaustive switches. The old client must compile, and old expression access must generate rename warnings. New API usage must compile without deprecation warnings.

**Scope:** 27 individual names associated with places, regions or demonyms, including ambiguous place-like names such as Apple Valley, Seabrook and Keppel. Other original color names are retained. No color values, order, package platforms or dependencies change.

## Verification results

- Baseline: 3 tests passed. New naming tests initially failed with 27 expected assertions.
- Final macOS suite: 9 tests passed, including all 280 original hex values/order and exhaustive switches over every original enum.
- External preferred-name client: typechecked with warnings treated as errors.
- External legacy-name client: typechecked successfully with expected rename diagnostics.
- iOS 13 simulator source typecheck: passed with expected deprecation warnings in compatibility accessors.
- Independent source review verified value/order preservation and migration documentation.
