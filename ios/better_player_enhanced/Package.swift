// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "better_player_enhanced",
    platforms: [
        .iOS("11.0")
    ],
    products: [
        .library(name: "better-player-enhanced", targets: ["better_player_enhanced"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "better_player_enhanced",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            path: "Sources/better_player_enhanced",
            publicHeadersPath: "include"
        )
    ]
)
