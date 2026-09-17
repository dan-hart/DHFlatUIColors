import SwiftUI

public struct DHFlatUIColors {
    public enum Palette: CaseIterable {
        @available(*, deprecated, renamed: "classic")
        case flatUiV1
        @available(*, deprecated, renamed: "breeze")
        case american
        @available(*, deprecated, renamed: "daybreak")
        case aussie
        @available(*, deprecated, renamed: "lantern")
        case british
        @available(*, deprecated, renamed: "confetti")
        case canadian
        @available(*, deprecated, renamed: "sunroom")
        case chinese
        @available(*, deprecated, renamed: "tapestry")
        case dutch
        @available(*, deprecated, renamed: "tidepool")
        case french
        @available(*, deprecated, renamed: "pinwheel")
        case german
        @available(*, deprecated, renamed: "wildflower")
        case indian
        @available(*, deprecated, renamed: "keepsake")
        case russian
        @available(*, deprecated, renamed: "kiln")
        case spanish
        @available(*, deprecated, renamed: "signal")
        case swedish
        @available(*, deprecated, renamed: "sherbet")
        case turkish

        /// Preferred spellings; legacy cases remain for exhaustive switch compatibility.
        public static var classic: Self { .flatUiV1 }
        public static var breeze: Self { .american }
        public static var daybreak: Self { .aussie }
        public static var lantern: Self { .british }
        public static var confetti: Self { .canadian }
        public static var sunroom: Self { .chinese }
        public static var tapestry: Self { .dutch }
        public static var tidepool: Self { .french }
        public static var pinwheel: Self { .german }
        public static var wildflower: Self { .indian }
        public static var keepsake: Self { .russian }
        public static var kiln: Self { .spanish }
        public static var signal: Self { .swedish }
        public static var sherbet: Self { .turkish }

        public static let allCases: [Self] = [
            .classic,
            .breeze,
            .daybreak,
            .lantern,
            .confetti,
            .sunroom,
            .tapestry,
            .tidepool,
            .pinwheel,
            .wildflower,
            .keepsake,
            .kiln,
            .signal,
            .sherbet,
        ]

        public var name: String {
            switch self {
            case .flatUiV1:
                return "Classic"
            case .american:
                return "Breeze"
            case .aussie:
                return "Daybreak"
            case .british:
                return "Lantern"
            case .canadian:
                return "Confetti"
            case .chinese:
                return "Sunroom"
            case .dutch:
                return "Tapestry"
            case .french:
                return "Tidepool"
            case .german:
                return "Pinwheel"
            case .indian:
                return "Wildflower"
            case .russian:
                return "Keepsake"
            case .spanish:
                return "Kiln"
            case .swedish:
                return "Signal"
            case .turkish:
                return "Sherbet"
            }
        }

        public var colors: [ColorInfo] {
            switch self {
            case .flatUiV1:
                return ClassicPalette.allCases.map { $0.info }
            case .american:
                return BreezePalette.allCases.map { $0.info }
            case .aussie:
                return DaybreakPalette.allCases.map { $0.info }
            case .british:
                return LanternPalette.allCases.map { $0.info }
            case .canadian:
                return ConfettiPalette.allCases.map { $0.info }
            case .chinese:
                return SunroomPalette.allCases.map { $0.info }
            case .dutch:
                return TapestryPalette.allCases.map { $0.info }
            case .french:
                return TidepoolPalette.allCases.map { $0.info }
            case .german:
                return PinwheelPalette.allCases.map { $0.info }
            case .indian:
                return WildflowerPalette.allCases.map { $0.info }
            case .russian:
                return KeepsakePalette.allCases.map { $0.info }
            case .spanish:
                return KilnPalette.allCases.map { $0.info }
            case .swedish:
                return SignalPalette.allCases.map { $0.info }
            case .turkish:
                return SherbetPalette.allCases.map { $0.info }
            }
        }
    }
}
