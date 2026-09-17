import SwiftUI

extension DHFlatUIColors {
    /// A curated nine-color subset of Classic, ordered for a compact color picker.
    public enum SimplePalette: CaseIterable {
        case alizarin
        case carrot
        case orange
        case emerald
        case turquoise
        case riverBlue
        case amethyst
        case pomegranate
        case greenSea

        public var info: ColorInfo {
            switch self {
            case .alizarin:
                return ColorInfo(name: "Alizarin", hex: "#E74C3C")
            case .carrot:
                return ColorInfo(name: "Carrot", hex: "#E67E22")
            case .orange:
                return ColorInfo(name: "Orange", hex: "#F39C12")
            case .emerald:
                return ColorInfo(name: "Emerald", hex: "#2ECC71")
            case .turquoise:
                return ColorInfo(name: "Turquoise", hex: "#1ABC9C")
            case .riverBlue:
                return ColorInfo(name: "River Blue", hex: "#3498DB")
            case .amethyst:
                return ColorInfo(name: "Amethyst", hex: "#9B59B6")
            case .pomegranate:
                return ColorInfo(name: "Pomegranate", hex: "#C0392B")
            case .greenSea:
                return ColorInfo(name: "Green Sea", hex: "#16A085")
            }
        }
    }
}
