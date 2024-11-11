
#if canImport(AppKit)
import AppKit

extension NSColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: CGFloat
        if hex.count == 6 {
            a = 1.0
            r = CGFloat((int >> 16) & 0xFF) / 255.0
            g = CGFloat((int >> 8) & 0xFF) / 255.0
            b = CGFloat(int & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
#endif
