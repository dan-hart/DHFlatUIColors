import SwiftUI

extension DHFlatUIColors {
    /// Generated November 11, 2024
    public enum KilnPalette: CaseIterable {
        /// Jacksons Purple Hex Value: #40407A
        case jacksonsPurple
        /// C64 Purple Hex Value: #706FD3
        case c64Purple
        /// Swan White Hex Value: #F7F1E3
        case swanWhite
        /// Summer Sky Hex Value: #34ACE0
        case summerSky
        /// Celestial Green Hex Value: #33D9B2
        case celestialGreen
        /// Lucky Point Hex Value: #2C2C54
        case luckyPoint
        /// Liberty Hex Value: #474787
        case liberty
        /// Hot Stone Hex Value: #AAA69D
        case hotStone
        /// Devil Blue Hex Value: #227093
        case devilBlue
        /// Poolside Hex Value: #218C74
        @available(*, deprecated, renamed: "poolside")
        case palmSpringsSplash
        /// Fluorescent Red Hex Value: #FF5252
        case fluorescentRed
        /// Synthetic Pumpkin Hex Value: #FF793F
        case syntheticPumpkin
        /// Crocodile Tooth Hex Value: #D1CCC0
        case crocodileTooth
        /// Mandarin Sorbet Hex Value: #FFB142
        case mandarinSorbet
        /// Spiced Butternut Hex Value: #FFDA79
        case spicedButternut
        /// Eye Of Newt Hex Value: #B33939
        case eyeOfNewt
        /// Ember Clay Hex Value: #CD6133
        @available(*, deprecated, renamed: "emberClay")
        case chileanFire
        /// Grey Porcelain Hex Value: #84817A
        case greyPorcelain
        /// Toasted Ochre Hex Value: #CC8E35
        @available(*, deprecated, renamed: "toastedOchre")
        case alamedaOchre
        /// Desert Hex Value: #CCAE62
        case desert

        /// Preferred spellings; legacy cases remain for exhaustive switch compatibility.
        public static var poolside: Self { .palmSpringsSplash }
        public static var emberClay: Self { .chileanFire }
        public static var toastedOchre: Self { .alamedaOchre }

        public static let allCases: [Self] = [
            .jacksonsPurple,
            .c64Purple,
            .swanWhite,
            .summerSky,
            .celestialGreen,
            .luckyPoint,
            .liberty,
            .hotStone,
            .devilBlue,
            .poolside,
            .fluorescentRed,
            .syntheticPumpkin,
            .crocodileTooth,
            .mandarinSorbet,
            .spicedButternut,
            .eyeOfNewt,
            .emberClay,
            .greyPorcelain,
            .toastedOchre,
            .desert,
        ]

        public var info: ColorInfo {
            switch self {
            case .jacksonsPurple:
                return ColorInfo(name: "Jacksons Purple", hex: "#40407A")
            case .c64Purple:
                return ColorInfo(name: "C64 Purple", hex: "#706FD3")
            case .swanWhite:
                return ColorInfo(name: "Swan White", hex: "#F7F1E3")
            case .summerSky:
                return ColorInfo(name: "Summer Sky", hex: "#34ACE0")
            case .celestialGreen:
                return ColorInfo(name: "Celestial Green", hex: "#33D9B2")
            case .luckyPoint:
                return ColorInfo(name: "Lucky Point", hex: "#2C2C54")
            case .liberty:
                return ColorInfo(name: "Liberty", hex: "#474787")
            case .hotStone:
                return ColorInfo(name: "Hot Stone", hex: "#AAA69D")
            case .devilBlue:
                return ColorInfo(name: "Devil Blue", hex: "#227093")
            case .palmSpringsSplash:
                return ColorInfo(name: "Poolside", hex: "#218C74")
            case .fluorescentRed:
                return ColorInfo(name: "Fluorescent Red", hex: "#FF5252")
            case .syntheticPumpkin:
                return ColorInfo(name: "Synthetic Pumpkin", hex: "#FF793F")
            case .crocodileTooth:
                return ColorInfo(name: "Crocodile Tooth", hex: "#D1CCC0")
            case .mandarinSorbet:
                return ColorInfo(name: "Mandarin Sorbet", hex: "#FFB142")
            case .spicedButternut:
                return ColorInfo(name: "Spiced Butternut", hex: "#FFDA79")
            case .eyeOfNewt:
                return ColorInfo(name: "Eye Of Newt", hex: "#B33939")
            case .chileanFire:
                return ColorInfo(name: "Ember Clay", hex: "#CD6133")
            case .greyPorcelain:
                return ColorInfo(name: "Grey Porcelain", hex: "#84817A")
            case .alamedaOchre:
                return ColorInfo(name: "Toasted Ochre", hex: "#CC8E35")
            case .desert:
                return ColorInfo(name: "Desert", hex: "#CCAE62")
            }
        }
    }
}
