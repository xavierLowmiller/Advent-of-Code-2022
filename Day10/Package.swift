// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day10",
    products: [
        .library(
            name: "Day10",
            targets: ["Day10"]),
    ],
    targets: [
        .target(
            name: "Day10",
            dependencies: []),
        .testTarget(
            name: "Day10Tests",
            dependencies: ["Day10"]),
    ]
)
