// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day11",
    products: [
        .library(
            name: "Day11",
            targets: ["Day11"]),
    ],
    targets: [
        .target(
            name: "Day11",
            dependencies: []),
        .testTarget(
            name: "Day11Tests",
            dependencies: ["Day11"]),
    ]
)
