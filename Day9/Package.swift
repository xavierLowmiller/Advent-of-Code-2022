// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day9",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "Day9",
            targets: ["Day9"]),
    ],
    targets: [
        .target(
            name: "Day9",
            dependencies: []),
        .testTarget(
            name: "Day9Tests",
            dependencies: ["Day9"]),
    ]
)
