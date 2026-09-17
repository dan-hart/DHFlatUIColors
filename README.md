# DHFlatUIColors

[![Latest release](https://img.shields.io/github/v/release/dan-hart/DHFlatUIColors?style=flat-square&color=8B5CF6)](https://github.com/dan-hart/DHFlatUIColors/releases/latest)
[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-FA7343?style=flat-square&logo=swift&logoColor=white)](#requirements)
[![Platforms: iOS, macOS, watchOS, tvOS](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-333333?style=flat-square&logo=apple&logoColor=white)](#requirements)
[![License: GPL v3](https://img.shields.io/badge/license-GPLv3-3B82F6?style=flat-square)](LICENSE.md)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-support-FFDD00?style=flat-square&logo=buymeacoffee&logoColor=black)](https://buymeacoffee.com/codedbydan)

Access 15 color palettes in Swift, with readable names, hex values, and SwiftUI colors. UIKit and AppKit color accessors are also available on supported platforms.

**Current release: [1.0.0](https://github.com/dan-hart/DHFlatUIColors/releases/tag/1.0.0)** — descriptive palette names, 27 individual color renames, and deprecated compatibility APIs for existing code.

**Unreleased on `main`:** the nine-color Simple palette described below is not included in 1.0.0.

## Interactive explorer

[Open the color explorer →](https://dan-hart.github.io/DHFlatUIColors/)

Browse all 15 palettes, search colors by name or hex, preview them in light and dark interfaces, check text contrast, and copy SwiftUI, UIKit, or AppKit accessors. The explorer uses the current source on `main` and clearly marks unreleased palettes.

See [explorer development and deployment](docs/explorer.md) for the source-data export and local preview workflow.

## Requirements

- Swift tools 5.9 or later
- iOS 13+, macOS 10.15+, watchOS 6+, or tvOS 13+

## Installation

Add [DHFlatUIColors](https://github.com/dan-hart/DHFlatUIColors) as a Swift Package dependency in Xcode, using version **1.0.0** or later within the same major version.

For a `Package.swift` manifest, add this entry to `dependencies`:

```swift
.package(url: "https://github.com/dan-hart/DHFlatUIColors.git", from: "1.0.0")
```

Then add the library product to your target's dependencies:

```swift
.product(name: "DHFlatUIColors", package: "DHFlatUIColors")
```

## Usage

### Access a color

```swift
import DHFlatUIColors

let colorInfo = DHFlatUIColors.KeepsakePalette.rosewater.info
let color = colorInfo.color // SwiftUI.Color
let hex = colorInfo.hex     // "#EA8685"
let name = colorInfo.name   // "Rosewater"

#if canImport(UIKit)
let nativeColor = colorInfo.uiColor
#elseif canImport(AppKit)
let nativeColor = colorInfo.nsColor
#endif
```

### Browse palettes and colors

```swift
import DHFlatUIColors

let palette = DHFlatUIColors.Palette.breeze
let colors = palette.colors // [ColorInfo]

for palette in DHFlatUIColors.Palette.allCases {
    print("Palette: \(palette.name)")
    for colorInfo in palette.colors {
        print("\(colorInfo.name): \(colorInfo.hex)")
    }
}
```

## Palettes

The 14 original palettes each contain 20 colors. Simple contains nine selected colors from Classic. Use `DHFlatUIColors.Palette` to browse palettes or the corresponding palette type to access individual colors.

| Name | Palette accessor | Color type |
|---|---|---|
| Classic | `.classic` | `ClassicPalette` |
| Breeze | `.breeze` | `BreezePalette` |
| Daybreak | `.daybreak` | `DaybreakPalette` |
| Lantern | `.lantern` | `LanternPalette` |
| Confetti | `.confetti` | `ConfettiPalette` |
| Sunroom | `.sunroom` | `SunroomPalette` |
| Tapestry | `.tapestry` | `TapestryPalette` |
| Tidepool | `.tidepool` | `TidepoolPalette` |
| Pinwheel | `.pinwheel` | `PinwheelPalette` |
| Wildflower | `.wildflower` | `WildflowerPalette` |
| Keepsake | `.keepsake` | `KeepsakePalette` |
| Kiln | `.kiln` | `KilnPalette` |
| Signal | `.signal` | `SignalPalette` |
| Sherbet | `.sherbet` | `SherbetPalette` |
| Simple (unreleased) | `.simple` | `SimplePalette` |

All color types are nested under `DHFlatUIColors`, such as `DHFlatUIColors.BreezePalette`.

## Simple palette (unreleased)

Simple provides the nine colors used by AsNeeded's color picker, in the same order and with identical hex values. The blue uses the current name River Blue in place of Peter River.

```swift
import DHFlatUIColors

let simpleColors = DHFlatUIColors.Palette.simple.colors
let blue = DHFlatUIColors.SimplePalette.riverBlue.info.color
```

| Color | Hex |
|---|---|
| Alizarin | `#E74C3C` |
| Carrot | `#E67E22` |
| Orange | `#F39C12` |
| Emerald | `#2ECC71` |
| Turquoise | `#1ABC9C` |
| River Blue | `#3498DB` |
| Amethyst | `#9B59B6` |
| Pomegranate | `#C0392B` |
| Green Sea | `#16A085` |

`Simple` is appended to `Palette.allCases`, preserving the original palettes' order. It is a new enum case: exhaustive switches over `Palette` must add `.simple` or a `default` branch when adopting this update. Existing individual color enums are unchanged.

## Migrating to 1.0.0

Version 1.0.0 introduces the 14 original palette names above and renames 27 individual colors associated with geographic names. All 280 hex values and their iteration order are unchanged.

- Previous palette types and renamed members remain available with deprecation warnings and compiler rename suggestions. No removal version is scheduled.
- Both old and new accessors return the new display names. Update any stored or compared display strings using the migration tables.
- In 1.0.0, existing exhaustive switches over the original enum cases continue to compile. The renamed palette and color members are static accessors during this transition, so switches using them need a `default` branch. The unreleased Simple addition requires the extra palette case described above.
- Clean source builds emit expected deprecation warnings inside the compatibility accessors, which reference the retained cases.

See the [complete migration guide](MIGRATION.md) for every palette and color rename, switch examples, and compatibility details.

## Attribution

The colors come from [Flat UI Colors](https://flatuicolors.com). This package provides Swift access and alternative names for the palettes and selected colors; it does not claim authorship of the colors.

## License

This project is licensed under the [GNU GPLv3 License](LICENSE.md).

## Support

<a href="https://buymeacoffee.com/codedbydan"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" width="217" height="60"></a>
