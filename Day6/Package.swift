// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day6",
    products: [
        .library(
            name: "Day6",
            targets: ["Day6"]),
    ],
    targets: [
        .target(
            name: "Day6",
            dependencies: []),
        .testTarget(
            name: "Day6Tests",
            dependencies: ["Day6"]),
    ]
)
