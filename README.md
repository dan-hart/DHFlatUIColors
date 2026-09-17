# DHFlatUIColors

An easy way to access Flat UI Colors in Swift.

## About

This Swift package provides access to Flat UI Colors, making it simple to use them in your Swift projects.

**Note:** I did not create these colors; this package simply provides an easy way to access them in Swift. All credit for the colors goes to [Flat UI Colors](https://flatuicolors.com).

## Installation

Add `DHFlatUIColors` to your project using Swift Package Manager.

## Usage

```swift
import DHFlatUIColors

// Access a specific color
let colorInfo = DHFlatUIColors.KeepsakePalette.rosewater.info
let color = colorInfo.color
let hex = colorInfo.hex
let name = colorInfo.name

// Iterate over all palettes and colors
for palette in DHFlatUIColors.Palette.allCases {
    print("Palette: \(palette.name)")
    for colorInfo in palette.colors {
        print("Color Name: \(colorInfo.name), Hex: \(colorInfo.hex)")
    }
}
```

## Naming transition

Palettes now use descriptive names such as Breeze, Keepsake, and Classic. Geographic color names have also been updated. Existing Swift names remain available with deprecation warnings and rename suggestions. Color values and iteration order are unchanged.

See the [migration guide](MIGRATION.md) for every rename and the temporary limitation when switching over the new static accessors.

## License

This project is licensed under the GNU GPLv3 License.
