import SwiftUI

extension DHFlatUIColors {
    /// Generated November 11, 2024
    public enum WildflowerPalette: CaseIterable {
        /// Orchid Orange Hex Value: #FEA47F
        case orchidOrange
        /// Spiro Disco Ball Hex Value: #25CCF7
        case spiroDiscoBall
        /// Honey Glow Hex Value: #EAB543
        case honeyGlow
        /// Sweet Garden Hex Value: #55E6C1
        case sweetGarden
        /// Falling Star Hex Value: #CAD3C8
        case fallingStar
        /// Rich Gardenia Hex Value: #F97F51
        case richGardenia
        /// Clear Chill Hex Value: #1B9CFC
        case clearChill
        /// Pale Linen Hex Value: #F8EFBA
        @available(*, deprecated, renamed: "paleLinen")
        case sarawakWhitePepper
        /// Garden Teal Hex Value: #58B19F
        @available(*, deprecated, renamed: "gardenTeal")
        case keppel
        /// Ship's Officer Hex Value: #2C3A47
        case shipsOfficer
        /// Fiery Fuchsia Hex Value: #B33771
        case fieryFuchsia
        /// Bluebell Hex Value: #3B3B98
        case bluebell
        /// Peach Blossom Hex Value: #FD7272
        @available(*, deprecated, renamed: "peachBlossom")
        case georgiaPeach
        /// Oasis Stream Hex Value: #9AECDB
        case oasisStream
        /// Bright Ube Hex Value: #D6A2E8
        case brightUbe
        /// Magenta Purple Hex Value: #6D214F
        case magentaPurple
        /// Ending Navy Blue Hex Value: #182C61
        case endingNavyBlue
        /// Sasquatch Socks Hex Value: #FC427B
        case sasquatchSocks
        /// Pine Glade Hex Value: #BDC581
        case pineGlade
        /// Highlighter Lavender Hex Value: #82589F
        case highlighterLavender

        /// Preferred spellings; legacy cases remain for exhaustive switch compatibility.
        public static var paleLinen: Self { .sarawakWhitePepper }
        public static var gardenTeal: Self { .keppel }
        public static var peachBlossom: Self { .georgiaPeach }

        public static let allCases: [Self] = [
            .orchidOrange,
            .spiroDiscoBall,
            .honeyGlow,
            .sweetGarden,
            .fallingStar,
            .richGardenia,
            .clearChill,
            .paleLinen,
            .gardenTeal,
            .shipsOfficer,
            .fieryFuchsia,
            .bluebell,
            .peachBlossom,
            .oasisStream,
            .brightUbe,
            .magentaPurple,
            .endingNavyBlue,
            .sasquatchSocks,
            .pineGlade,
            .highlighterLavender,
        ]

        public var info: ColorInfo {
            switch self {
            case .orchidOrange:
                return ColorInfo(name: "Orchid Orange", hex: "#FEA47F")
            case .spiroDiscoBall:
                return ColorInfo(name: "Spiro Disco Ball", hex: "#25CCF7")
            case .honeyGlow:
                return ColorInfo(name: "Honey Glow", hex: "#EAB543")
            case .sweetGarden:
                return ColorInfo(name: "Sweet Garden", hex: "#55E6C1")
            case .fallingStar:
                return ColorInfo(name: "Falling Star", hex: "#CAD3C8")
            case .richGardenia:
                return ColorInfo(name: "Rich Gardenia", hex: "#F97F51")
            case .clearChill:
                return ColorInfo(name: "Clear Chill", hex: "#1B9CFC")
            case .sarawakWhitePepper:
                return ColorInfo(name: "Pale Linen", hex: "#F8EFBA")
            case .keppel:
                return ColorInfo(name: "Garden Teal", hex: "#58B19F")
            case .shipsOfficer:
                return ColorInfo(name: "Ship's Officer", hex: "#2C3A47")
            case .fieryFuchsia:
                return ColorInfo(name: "Fiery Fuchsia", hex: "#B33771")
            case .bluebell:
                return ColorInfo(name: "Bluebell", hex: "#3B3B98")
            case .georgiaPeach:
                return ColorInfo(name: "Peach Blossom", hex: "#FD7272")
            case .oasisStream:
                return ColorInfo(name: "Oasis Stream", hex: "#9AECDB")
            case .brightUbe:
                return ColorInfo(name: "Bright Ube", hex: "#D6A2E8")
            case .magentaPurple:
                return ColorInfo(name: "Magenta Purple", hex: "#6D214F")
            case .endingNavyBlue:
                return ColorInfo(name: "Ending Navy Blue", hex: "#182C61")
            case .sasquatchSocks:
                return ColorInfo(name: "Sasquatch Socks", hex: "#FC427B")
            case .pineGlade:
                return ColorInfo(name: "Pine Glade", hex: "#BDC581")
            case .highlighterLavender:
                return ColorInfo(name: "Highlighter Lavender", hex: "#82589F")
            }
        }
    }
}
