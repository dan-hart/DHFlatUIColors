import SwiftUI

extension DHFlatUIColors {
    /// Generated November 11, 2024
    public enum TidepoolPalette: CaseIterable {
        /// Flat Flesh Hex Value: #FAD390
        case flatFlesh
        /// Melon Melody Hex Value: #F8C291
        case melonMelody
        /// Livid Hex Value: #6A89CC
        case livid
        /// Spray Hex Value: #82CCDD
        case spray
        /// Paradise Green Hex Value: #B8E994
        case paradiseGreen
        /// Squash Blossom Hex Value: #F6B93B
        case squashBlossom
        /// Mandarin Red Hex Value: #E55039
        case mandarinRed
        /// Dusk Blue Hex Value: #4A69BD
        @available(*, deprecated, renamed: "duskBlue")
        case azraqBlue
        /// Dupain Hex Value: #60A3BC
        case dupain
        /// Aurora Green Hex Value: #78E08F
        case auroraGreen
        /// Amber Petal Hex Value: #FA983A
        @available(*, deprecated, renamed: "amberPetal")
        case icelandPoppy
        /// Tomato Red Hex Value: #EB2F06
        case tomatoRed
        /// Yuè Guāng Lán Blue Hex Value: #1E3799
        case yuèGuāngLánBlue
        /// Good Samaritan Hex Value: #3C6382
        case goodSamaritan
        /// Waterfall Hex Value: #38ADA9
        case waterfall
        /// Carrot Orange Hex Value: #E58E26
        case carrotOrange
        /// Jalapeno Red Hex Value: #B71540
        case jalapenoRed
        /// Dark Sapphire Hex Value: #0C2461
        case darkSapphire
        /// Forest Blues Hex Value: #0A3D62
        case forestBlues
        /// Reef Encounter Hex Value: #079992
        case reefEncounter

        /// Preferred spellings; legacy cases remain for exhaustive switch compatibility.
        public static var duskBlue: Self { .azraqBlue }
        public static var amberPetal: Self { .icelandPoppy }

        public static let allCases: [Self] = [
            .flatFlesh,
            .melonMelody,
            .livid,
            .spray,
            .paradiseGreen,
            .squashBlossom,
            .mandarinRed,
            .duskBlue,
            .dupain,
            .auroraGreen,
            .amberPetal,
            .tomatoRed,
            .yuèGuāngLánBlue,
            .goodSamaritan,
            .waterfall,
            .carrotOrange,
            .jalapenoRed,
            .darkSapphire,
            .forestBlues,
            .reefEncounter,
        ]

        public var info: ColorInfo {
            switch self {
            case .flatFlesh:
                return ColorInfo(name: "Flat Flesh", hex: "#FAD390")
            case .melonMelody:
                return ColorInfo(name: "Melon Melody", hex: "#F8C291")
            case .livid:
                return ColorInfo(name: "Livid", hex: "#6A89CC")
            case .spray:
                return ColorInfo(name: "Spray", hex: "#82CCDD")
            case .paradiseGreen:
                return ColorInfo(name: "Paradise Green", hex: "#B8E994")
            case .squashBlossom:
                return ColorInfo(name: "Squash Blossom", hex: "#F6B93B")
            case .mandarinRed:
                return ColorInfo(name: "Mandarin Red", hex: "#E55039")
            case .azraqBlue:
                return ColorInfo(name: "Dusk Blue", hex: "#4A69BD")
            case .dupain:
                return ColorInfo(name: "Dupain", hex: "#60A3BC")
            case .auroraGreen:
                return ColorInfo(name: "Aurora Green", hex: "#78E08F")
            case .icelandPoppy:
                return ColorInfo(name: "Amber Petal", hex: "#FA983A")
            case .tomatoRed:
                return ColorInfo(name: "Tomato Red", hex: "#EB2F06")
            case .yuèGuāngLánBlue:
                return ColorInfo(name: "Yuè Guāng Lán Blue", hex: "#1E3799")
            case .goodSamaritan:
                return ColorInfo(name: "Good Samaritan", hex: "#3C6382")
            case .waterfall:
                return ColorInfo(name: "Waterfall", hex: "#38ADA9")
            case .carrotOrange:
                return ColorInfo(name: "Carrot Orange", hex: "#E58E26")
            case .jalapenoRed:
                return ColorInfo(name: "Jalapeno Red", hex: "#B71540")
            case .darkSapphire:
                return ColorInfo(name: "Dark Sapphire", hex: "#0C2461")
            case .forestBlues:
                return ColorInfo(name: "Forest Blues", hex: "#0A3D62")
            case .reefEncounter:
                return ColorInfo(name: "Reef Encounter", hex: "#079992")
            }
        }
    }
}
