import XCTest
import DHFlatUIColors

final class SimplePaletteTests: XCTestCase {
    func testSimplePublicAPIAndRegistration() {
        XCTAssertEqual(DHFlatUIColors.Palette.simple.name, "Simple")
        XCTAssertEqual(DHFlatUIColors.Palette.simple.colors, DHFlatUIColors.SimplePalette.allCases.map(\.info))
        XCTAssertEqual(DHFlatUIColors.Palette.allCases.filter { $0 == .simple }.count, 1)
        XCTAssertEqual(DHFlatUIColors.Palette.allCases.last, .simple)
        XCTAssertEqual(DHFlatUIColors.SimplePalette.riverBlue.info.hex, "#3498DB")
    }

    func testSimpleContainsExactlyTheCuratedColorsInOrder() throws {
        let palette = try XCTUnwrap(DHFlatUIColors.Palette.allCases.first { $0.name == "Simple" })
        XCTAssertEqual(palette.colors.map(\.name), [
            "Alizarin", "Carrot", "Orange", "Emerald", "Turquoise",
            "River Blue", "Amethyst", "Pomegranate", "Green Sea",
        ])
        XCTAssertEqual(palette.colors.map(\.hex), [
            "#E74C3C", "#E67E22", "#F39C12", "#2ECC71", "#1ABC9C",
            "#3498DB", "#9B59B6", "#C0392B", "#16A085",
        ])
        XCTAssertEqual(Set(palette.colors.map(\.hex)).count, 9)
    }
}
