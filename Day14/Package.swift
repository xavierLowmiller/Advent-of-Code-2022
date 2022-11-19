// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day14",
    products: [
        .library(
            name: "Day14",
            targets: ["Day14"]),
    ],
    targets: [
        .target(
            name: "Day14",
            dependencies: []),
        .testTarget(
            name: "Day14Tests",
            dependencies: ["Day14"]),
    ]
)
