// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day15",
    products: [
        .library(
            name: "Day15",
            targets: ["Day15"]),
    ],
    targets: [
        .target(
            name: "Day15",
            dependencies: []),
        .testTarget(
            name: "Day15Tests",
            dependencies: ["Day15"]),
    ]
)
