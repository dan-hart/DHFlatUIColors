import XCTest
import DHFlatUIColors

final class NamingTransitionTests: XCTestCase {
    func testPreferredPaletteNames() {
        XCTAssertEqual(DHFlatUIColors.Palette.allCases.map(\.name), [
            "Classic",
            "Breeze",
            "Daybreak",
            "Lantern",
            "Confetti",
            "Sunroom",
            "Tapestry",
            "Tidepool",
            "Pinwheel",
            "Wildflower",
            "Keepsake",
            "Kiln",
            "Signal",
            "Sherbet",
            "Simple",
        ])
    }

    func testOriginalHexValuesAndOrderArePreserved() {
        let expected: [[String]] = [
            ["#1ABC9C", "#2ECC71", "#3498DB", "#9B59B6", "#34495E", "#16A085", "#27AE60", "#2980B9", "#8E44AD", "#2C3E50", "#F1C40F", "#E67E22", "#E74C3C", "#ECF0F1", "#95A5A6", "#F39C12", "#D35400", "#C0392B", "#BDC3C7", "#7F8C8D"],
            ["#55EFC4", "#81ECEC", "#74B9FF", "#A29BFE", "#DFE6E9", "#00B894", "#00CEC9", "#0984E3", "#6C5CE7", "#B2BEC3", "#FFEAA7", "#FAB1A0", "#FF7675", "#FD79A8", "#636E72", "#FDCB6E", "#E17055", "#D63031", "#E84393", "#2D3436"],
            ["#F6E58D", "#FFBE76", "#FF7979", "#BADC58", "#DFF9FB", "#F9CA24", "#F0932B", "#EB4D4B", "#6AB04C", "#C7ECEE", "#7ED6DF", "#E056FD", "#686DE0", "#30336B", "#95AFC0", "#22A6B3", "#BE2EDD", "#4834D4", "#130F40", "#535C68"],
            ["#00A8FF", "#9C88FF", "#FBC531", "#4CD137", "#487EB0", "#0097E6", "#8C7AE6", "#E1B12C", "#44BD32", "#40739E", "#E84118", "#F5F6FA", "#7F8FA6", "#273C75", "#353B48", "#C23616", "#DCDDE1", "#718093", "#192A56", "#2F3640"],
            ["#FF9FF3", "#FECA57", "#FF6B6B", "#48DBFB", "#1DD1A1", "#F368E0", "#FF9F43", "#EE5253", "#0ABDE3", "#10AC84", "#00D2D3", "#54A0FF", "#5F27CD", "#C8D6E5", "#576574", "#01A3A4", "#2E86DE", "#341F97", "#8395A7", "#222F3E"],
            ["#ECCC68", "#FF7F50", "#FF6B81", "#A4B0BE", "#57606F", "#FFA502", "#FF6348", "#FF4757", "#747D8C", "#2F3542", "#7BED9F", "#70A1FF", "#5352ED", "#FFFFFF", "#DFE4EA", "#2ED573", "#1E90FF", "#3742FA", "#F1F2F6", "#CED6E0"],
            ["#FFC312", "#C4E538", "#12CBC4", "#FDA7DF", "#ED4C67", "#F79F1F", "#A3CB38", "#1289A7", "#D980FA", "#B53471", "#EE5A24", "#009432", "#0652DD", "#9980FA", "#833471", "#EA2027", "#006266", "#1B1464", "#5758BB", "#6F1E51"],
            ["#FAD390", "#F8C291", "#6A89CC", "#82CCDD", "#B8E994", "#F6B93B", "#E55039", "#4A69BD", "#60A3BC", "#78E08F", "#FA983A", "#EB2F06", "#1E3799", "#3C6382", "#38ADA9", "#E58E26", "#B71540", "#0C2461", "#0A3D62", "#079992"],
            ["#FC5C65", "#FD9644", "#FED330", "#26DE81", "#2BCBBA", "#EB3B5A", "#FA8231", "#F7B731", "#20BF6B", "#0FB9B1", "#45AAF2", "#4B7BEC", "#A55EEA", "#D1D8E0", "#778CA3", "#2D98DA", "#3867D6", "#8854D0", "#A5B1C2", "#4B6584"],
            ["#FEA47F", "#25CCF7", "#EAB543", "#55E6C1", "#CAD3C8", "#F97F51", "#1B9CFC", "#F8EFBA", "#58B19F", "#2C3A47", "#B33771", "#3B3B98", "#FD7272", "#9AECDB", "#D6A2E8", "#6D214F", "#182C61", "#FC427B", "#BDC581", "#82589F"],
            ["#F3A683", "#F7D794", "#778BEB", "#E77F67", "#CF6A87", "#F19066", "#F5CD79", "#546DE5", "#E15F41", "#C44569", "#786FA6", "#F8A5C2", "#63CDDA", "#EA8685", "#596275", "#574B90", "#F78FB3", "#3DC1D3", "#E66767", "#303952"],
            ["#40407A", "#706FD3", "#F7F1E3", "#34ACE0", "#33D9B2", "#2C2C54", "#474787", "#AAA69D", "#227093", "#218C74", "#FF5252", "#FF793F", "#D1CCC0", "#FFB142", "#FFDA79", "#B33939", "#CD6133", "#84817A", "#CC8E35", "#CCAE62"],
            ["#EF5777", "#575FCF", "#4BCFFA", "#34E7E4", "#0BE881", "#F53B57", "#3C40C6", "#0FBCF9", "#00D8D6", "#05C46B", "#FFC048", "#FFDD59", "#FF5E57", "#D2DAE2", "#485460", "#FFA801", "#FFD32A", "#FF3F34", "#808E9B", "#1E272E"],
            ["#CD84F1", "#FFCCCC", "#FF4D4D", "#FFAF40", "#FFFA65", "#C56CF0", "#FFB8B8", "#FF3838", "#FF9F1A", "#FFF200", "#32FF7E", "#7EFFF5", "#18DCFF", "#7D5FFF", "#4B4B4B", "#3AE374", "#67E6DC", "#17C0EB", "#7158E2", "#3D3D3D"],
        ]
        XCTAssertEqual(DHFlatUIColors.Palette.allCases.filter { $0 != .simple }.map { $0.colors.map(\.hex) }, expected)
    }

    func testGeographicColorDisplayNamesAreReplaced() {
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[2].colors[13].name, "Midnight Ink")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[0].colors[2].name, "River Blue")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[0].colors[7].name, "Deep Water")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[1].colors[14].name, "River Stone")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[1].colors[16].name, "Baked Clay")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[2].colors[15].name, "Lagoon")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[3].colors[4].name, "Harbor Blue")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[4].colors[4].name, "Sea Glass")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[4].colors[16].name, "Clear Blue")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[5].colors[11].name, "Open Sky")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[5].colors[17].name, "Vivid Iris")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[6].colors[7].name, "Deep Lagoon")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[6].colors[16].name, "Shaded Teal")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[7].colors[7].name, "Dusk Blue")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[7].colors[10].name, "Amber Petal")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[8].colors[7].name, "Golden Cab")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[9].colors[7].name, "Pale Linen")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[9].colors[8].name, "Garden Teal")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[9].colors[12].name, "Peach Blossom")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[10].colors[13].name, "Rosewater")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[10].colors[17].name, "Blue Ripple")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[10].colors[19].name, "Evening Slate")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[11].colors[9].name, "Poolside")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[11].colors[16].name, "Ember Clay")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[11].colors[18].name, "Toasted Ochre")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[12].colors[18].name, "Pavement")
        XCTAssertEqual(DHFlatUIColors.Palette.allCases[13].colors[19].name, "Charcoal")
    }
}
