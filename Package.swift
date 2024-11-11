// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "DHFlatUIColors",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
        // Uncomment the next line when visionOS support is available
        // .visionOS(.v1)
    ],
    products: [
        .library(
            name: "DHFlatUIColors",
            targets: ["DHFlatUIColors"]),
    ],
    targets: [
        .target(
            name: "DHFlatUIColors",
            dependencies: []),
        .testTarget(
            name: "DHFlatUIColorsTests",
            dependencies: ["DHFlatUIColors"]),
    ]
)
