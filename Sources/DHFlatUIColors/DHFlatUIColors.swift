import SwiftUI

public struct DHFlatUIColors {
    public enum Palette: CaseIterable {
        case flatUiV1
        case american
        case aussie
        case british
        case canadian
        case chinese
        case dutch
        case french
        case german
        case indian
        case russian
        case spanish
        case swedish
        case turkish

        public var name: String {
            switch self {
            case .flatUiV1:
                return "Flat UI  v1"
            case .american:
                return "American"
            case .aussie:
                return "Aussie"
            case .british:
                return "British"
            case .canadian:
                return "Canadian"
            case .chinese:
                return "Chinese"
            case .dutch:
                return "Dutch"
            case .french:
                return "French"
            case .german:
                return "German"
            case .indian:
                return "Indian"
            case .russian:
                return "Russian"
            case .spanish:
                return "Spanish"
            case .swedish:
                return "Swedish"
            case .turkish:
                return "Turkish"
            }
        }

        public var colors: [ColorInfo] {
            switch self {
            case .flatUiV1:
                return Flatuiv1Palette.allCases.map { $0.info }
            case .american:
                return AmericanPalette.allCases.map { $0.info }
            case .aussie:
                return AussiePalette.allCases.map { $0.info }
            case .british:
                return BritishPalette.allCases.map { $0.info }
            case .canadian:
                return CanadianPalette.allCases.map { $0.info }
            case .chinese:
                return ChinesePalette.allCases.map { $0.info }
            case .dutch:
                return DutchPalette.allCases.map { $0.info }
            case .french:
                return FrenchPalette.allCases.map { $0.info }
            case .german:
                return GermanPalette.allCases.map { $0.info }
            case .indian:
                return IndianPalette.allCases.map { $0.info }
            case .russian:
                return RussianPalette.allCases.map { $0.info }
            case .spanish:
                return SpanishPalette.allCases.map { $0.info }
            case .swedish:
                return SwedishPalette.allCases.map { $0.info }
            case .turkish:
                return TurkishPalette.allCases.map { $0.info }
            }
        }
    }
}
