import SwiftUI

extension DHFlatUIColors {
    /// Generated November 11, 2024
    public enum DaybreakPalette: CaseIterable {
        /// Beekeeper Hex Value: #F6E58D
        case beekeeper
        /// Spiced Nectarine Hex Value: #FFBE76
        case spicedNectarine
        /// Pink Glamour Hex Value: #FF7979
        case pinkGlamour
        /// June Bud Hex Value: #BADC58
        case juneBud
        /// Coastal Breeze Hex Value: #DFF9FB
        case coastalBreeze
        /// Turbo Hex Value: #F9CA24
        case turbo
        /// Quince Jelly Hex Value: #F0932B
        case quinceJelly
        /// Carmine Pink Hex Value: #EB4D4B
        case carminePink
        /// Pure Apple Hex Value: #6AB04C
        case pureApple
        /// Hint of Ice Pack Hex Value: #C7ECEE
        case hintOfIcePack
        /// Middle Blue Hex Value: #7ED6DF
        case middleBlue
        /// Heliotrope Hex Value: #E056FD
        case heliotrope
        /// Exodus Fruit Hex Value: #686DE0
        case exodusFruit
        /// Midnight Ink Hex Value: #30336B
        @available(*, deprecated, renamed: "midnightInk")
        case deepKoamaru
        /// Soaring Eagle Hex Value: #95AFC0
        case soaringEagle
        /// Lagoon Hex Value: #22A6B3
        @available(*, deprecated, renamed: "lagoon")
        case greenlandGreen
        /// Steel Pink Hex Value: #BE2EDD
        case steelPink
        /// Blurple Hex Value: #4834D4
        case blurple
        /// Deep Cove Hex Value: #130F40
        case deepCove
        /// Wizard Grey Hex Value: #535C68
        case wizardGrey

        /// Preferred spellings; legacy cases remain for exhaustive switch compatibility.
        public static var midnightInk: Self { .deepKoamaru }
        public static var lagoon: Self { .greenlandGreen }

        public static let allCases: [Self] = [
            .beekeeper,
            .spicedNectarine,
            .pinkGlamour,
            .juneBud,
            .coastalBreeze,
            .turbo,
            .quinceJelly,
            .carminePink,
            .pureApple,
            .hintOfIcePack,
            .middleBlue,
            .heliotrope,
            .exodusFruit,
            .midnightInk,
            .soaringEagle,
            .lagoon,
            .steelPink,
            .blurple,
            .deepCove,
            .wizardGrey,
        ]

        public var info: ColorInfo {
            switch self {
            case .beekeeper:
                return ColorInfo(name: "Beekeeper", hex: "#F6E58D")
            case .spicedNectarine:
                return ColorInfo(name: "Spiced Nectarine", hex: "#FFBE76")
            case .pinkGlamour:
                return ColorInfo(name: "Pink Glamour", hex: "#FF7979")
            case .juneBud:
                return ColorInfo(name: "June Bud", hex: "#BADC58")
            case .coastalBreeze:
                return ColorInfo(name: "Coastal Breeze", hex: "#DFF9FB")
            case .turbo:
                return ColorInfo(name: "Turbo", hex: "#F9CA24")
            case .quinceJelly:
                return ColorInfo(name: "Quince Jelly", hex: "#F0932B")
            case .carminePink:
                return ColorInfo(name: "Carmine Pink", hex: "#EB4D4B")
            case .pureApple:
                return ColorInfo(name: "Pure Apple", hex: "#6AB04C")
            case .hintOfIcePack:
                return ColorInfo(name: "Hint of Ice Pack", hex: "#C7ECEE")
            case .middleBlue:
                return ColorInfo(name: "Middle Blue", hex: "#7ED6DF")
            case .heliotrope:
                return ColorInfo(name: "Heliotrope", hex: "#E056FD")
            case .exodusFruit:
                return ColorInfo(name: "Exodus Fruit", hex: "#686DE0")
            case .deepKoamaru:
                return ColorInfo(name: "Midnight Ink", hex: "#30336B")
            case .soaringEagle:
                return ColorInfo(name: "Soaring Eagle", hex: "#95AFC0")
            case .greenlandGreen:
                return ColorInfo(name: "Lagoon", hex: "#22A6B3")
            case .steelPink:
                return ColorInfo(name: "Steel Pink", hex: "#BE2EDD")
            case .blurple:
                return ColorInfo(name: "Blurple", hex: "#4834D4")
            case .deepCove:
                return ColorInfo(name: "Deep Cove", hex: "#130F40")
            case .wizardGrey:
                return ColorInfo(name: "Wizard Grey", hex: "#535C68")
            }
        }
    }
}
