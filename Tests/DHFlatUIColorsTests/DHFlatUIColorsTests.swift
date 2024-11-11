import XCTest
@testable import DHFlatUIColors

final class DHFlatUIColorsTests: XCTestCase {

    func testColorInitialization() {
        // Test a specific color
        let alizarin = DHFlatUIColors.RussianPalette.appleValley.info
        XCTAssertEqual(alizarin.name, "Apple Valley")
        XCTAssertEqual(alizarin.hex.uppercased(), "#EA8685")
    }

    func testAllPalettes() {
        for palette in DHFlatUIColors.Palette.allCases {
            XCTAssertFalse(palette.name.isEmpty)
            XCTAssertFalse(palette.colors.isEmpty)
        }
    }

    func testColorValues() {
        for palette in DHFlatUIColors.Palette.allCases {
            for colorInfo in palette.colors {
                XCTAssertFalse(colorInfo.name.isEmpty)
                XCTAssertTrue(colorInfo.hex.hasPrefix("#"))
                XCTAssertEqual(colorInfo.hex.count, 7) // '#' + 6 hex digits
            }
        }
    }
}
