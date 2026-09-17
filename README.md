# DHFlatUIColors

Access 280 colors across 14 palettes in Swift, with readable names, hex values, and SwiftUI colors. UIKit and AppKit color accessors are also available on supported platforms.

**Current release: [1.0.0](https://github.com/dan-hart/DHFlatUIColors/releases/tag/1.0.0)** — descriptive palette names, 27 individual color renames, and deprecated compatibility APIs for existing code.

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

Each palette contains 20 colors. Use `DHFlatUIColors.Palette` to browse palettes or the corresponding palette type to access individual colors.

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

All color types are nested under `DHFlatUIColors`, such as `DHFlatUIColors.BreezePalette`.

## Migrating to 1.0.0

Version 1.0.0 introduces the names above and renames 27 individual colors associated with geographic names. All 280 hex values and their iteration order are unchanged.

- Previous palette types and renamed members remain available with deprecation warnings and compiler rename suggestions. No removal version is scheduled.
- Both old and new accessors return the new display names. Update any stored or compared display strings using the migration tables.
- Existing exhaustive switches over the original enum cases continue to compile. The preferred names are static accessors during this transition, so switches using them need a `default` branch.
- Clean source builds emit expected deprecation warnings inside the compatibility accessors, which reference the retained cases.

See the [complete migration guide](MIGRATION.md) for every palette and color rename, switch examples, and compatibility details.

## Attribution

The colors come from [Flat UI Colors](https://flatuicolors.com). This package provides Swift access and alternative names for the palettes and selected colors; it does not claim authorship of the colors.

## License

This project is licensed under the [GNU GPLv3 License](LICENSE.md).
