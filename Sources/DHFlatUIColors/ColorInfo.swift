import SwiftUI

public struct ColorInfo: Hashable {
    public let name: String
    public let hex: String
    public var color: Color {
        Color(hex: hex)
    }

#if canImport(UIKit)
    public var uiColor: UIColor {
        UIColor(hex: hex)
    }
#elseif canImport(AppKit)
    public var nsColor: NSColor {
        NSColor(hex: hex)
    }
#endif
}
