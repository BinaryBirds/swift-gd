// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "swift-gd",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "SwiftGD", targets: ["SwiftGD"]),
    ],
    dependencies: [
    ],
    targets: [
        .systemLibrary(
            name: "CLibGD",
            pkgConfig: "gdlib",
            providers: [
                .brew(["gd"]),
                .apt(["libgd-dev"]),
            ]
        ),
        .target(
            name: "SwiftGD",
            dependencies: [
                .target(name: "CLibGD"),
            ]
        ),
        .testTarget(
            name: "SwiftGDTests",
            dependencies: [
                .target(name: "SwiftGD"),
            ]
        )
    ]
)
