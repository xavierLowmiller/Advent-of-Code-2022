// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day12",
    products: [
        .library(
            name: "Day12",
            targets: ["Day12"]),
    ],
    targets: [
        .target(
            name: "Day12",
            dependencies: []),
        .testTarget(
            name: "Day12Tests",
            dependencies: ["Day12"]),
    ]
)
