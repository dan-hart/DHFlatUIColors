# Naming migration

## Unreleased: Simple palette

The new `DHFlatUIColors.SimplePalette` contains nine selected Classic colors. Access it through `DHFlatUIColors.Palette.simple`; it is appended to `Palette.allCases`. It is not included in release 1.0.0.

Adding `.simple` expands the `Palette` enum: existing exhaustive switches over palettes must add `case .simple` or a `default` branch. The compatibility notes below describe the 1.0.0 naming transition; existing individual color enums remain unchanged.

## Version 1.0.0 naming transition

Palette and geographic color names now use the names below. All 280 hex values and their order are unchanged. Individual color names without geographic references retain their original spellings.

## Preferred API

```swift
let palette = DHFlatUIColors.Palette.breeze
let color = DHFlatUIColors.BreezePalette.riverStone.info
```

## Compatibility during the transition

Old palette types remain available as deprecated type aliases. Old palette cases and renamed color cases remain actual enum cases, marked deprecated with compiler rename suggestions. Preferred names are static computed properties returning the same values. Old and new spellings compare equal, and `allCases` contains each value exactly once. Both spellings return the new display names. A clean source build also emits expected deprecation warnings inside the compatibility accessors, which deliberately reference the retained cases.

Keeping the old cases preserves existing exhaustive switches. During this transition, switches using preferred static properties need a `default` branch; Swift does not count static properties as exhaustive enum cases. For example:

```swift
switch palette {
case .breeze:
    print("Breeze")
default:
    print(palette.name)
}
```

The underlying case identities (including reflection and debug descriptions) still use legacy names. A future major release can make preferred names actual cases and remove deprecated spellings; that change is not part of this update. No removal version is scheduled.

Display names are presentation text, not persistent identifiers. If an application stores or compares the old display strings, migrate those strings using these tables. Hex values are unchanged.

## Palettes

| Old type / case | Preferred type / accessor | Display name |
|---|---|---|
| `Flatuiv1Palette` / `.flatUiV1` | `ClassicPalette` / `.classic` | Classic |
| `AmericanPalette` / `.american` | `BreezePalette` / `.breeze` | Breeze |
| `AussiePalette` / `.aussie` | `DaybreakPalette` / `.daybreak` | Daybreak |
| `BritishPalette` / `.british` | `LanternPalette` / `.lantern` | Lantern |
| `CanadianPalette` / `.canadian` | `ConfettiPalette` / `.confetti` | Confetti |
| `ChinesePalette` / `.chinese` | `SunroomPalette` / `.sunroom` | Sunroom |
| `DutchPalette` / `.dutch` | `TapestryPalette` / `.tapestry` | Tapestry |
| `FrenchPalette` / `.french` | `TidepoolPalette` / `.tidepool` | Tidepool |
| `GermanPalette` / `.german` | `PinwheelPalette` / `.pinwheel` | Pinwheel |
| `IndianPalette` / `.indian` | `WildflowerPalette` / `.wildflower` | Wildflower |
| `RussianPalette` / `.russian` | `KeepsakePalette` / `.keepsake` | Keepsake |
| `SpanishPalette` / `.spanish` | `KilnPalette` / `.kiln` | Kiln |
| `SwedishPalette` / `.swedish` | `SignalPalette` / `.signal` | Signal |
| `TurkishPalette` / `.turkish` | `SherbetPalette` / `.sherbet` | Sherbet |

## Individual colors

Use the preferred palette types above with the following color accessors. Unlisted color members keep their existing names.

| Palette | Old name / case | Preferred name / accessor |
|---|---|---|
| Classic | PETER RIVER / `.peterRiver` | River Blue / `.riverBlue` |
| Classic | BELIZE HOLE / `.belizeHole` | Deep Water / `.deepWater` |
| Breeze | American River / `.americanRiver` | River Stone / `.riverStone` |
| Breeze | Orangeville / `.orangeville` | Baked Clay / `.bakedClay` |
| Daybreak | Deep Koamaru / `.deepKoamaru` | Midnight Ink / `.midnightInk` |
| Daybreak | Greenland Green / `.greenlandGreen` | Lagoon / `.lagoon` |
| Lantern | Seabrook / `.seabrook` | Harbor Blue / `.harborBlue` |
| Confetti | Wild Caribbean Green / `.wildCaribbeanGreen` | Sea Glass / `.seaGlass` |
| Confetti | Bleu De France / `.bleuDeFrance` | Clear Blue / `.clearBlue` |
| Sunroom | French Sky Blue / `.frenchSkyBlue` | Open Sky / `.openSky` |
| Sunroom | Bright Greek / `.brightGreek` | Vivid Iris / `.vividIris` |
| Tapestry | Mediterranean Sea / `.mediterraneanSea` | Deep Lagoon / `.deepLagoon` |
| Tapestry | Turkish Aqua / `.turkishAqua` | Shaded Teal / `.shadedTeal` |
| Tidepool | Azraq Blue / `.azraqBlue` | Dusk Blue / `.duskBlue` |
| Tidepool | Iceland Poppy / `.icelandPoppy` | Amber Petal / `.amberPetal` |
| Pinwheel | NYC Taxi / `.nycTaxi` | Golden Cab / `.goldenCab` |
| Wildflower | Sarawak White Pepper / `.sarawakWhitePepper` | Pale Linen / `.paleLinen` |
| Wildflower | Keppel / `.keppel` | Garden Teal / `.gardenTeal` |
| Wildflower | Georgia Peach / `.georgiaPeach` | Peach Blossom / `.peachBlossom` |
| Keepsake | Apple Valley / `.appleValley` | Rosewater / `.rosewater` |
| Keepsake | Blue Curacao / `.blueCuracao` | Blue Ripple / `.blueRipple` |
| Keepsake | Biscay / `.biscay` | Evening Slate / `.eveningSlate` |
| Kiln | Palm Springs Splash / `.palmSpringsSplash` | Poolside / `.poolside` |
| Kiln | Chilean Fire / `.chileanFire` | Ember Clay / `.emberClay` |
| Kiln | Alameda Ochre / `.alamedaOchre` | Toasted Ochre / `.toastedOchre` |
| Signal | London Square / `.londonSquare` | Pavement / `.pavement` |
| Sherbet | Baltic Sea / `.balticSea` | Charcoal / `.charcoal` |
