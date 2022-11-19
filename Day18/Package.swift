// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day18",
    products: [
        .library(
            name: "Day18",
            targets: ["Day18"]),
    ],
    targets: [
        .target(
            name: "Day18",
            dependencies: []),
        .testTarget(
            name: "Day18Tests",
            dependencies: ["Day18"]),
    ]
)
