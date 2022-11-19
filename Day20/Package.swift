// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day20",
    products: [
        .library(
            name: "Day20",
            targets: ["Day20"]),
    ],
    targets: [
        .target(
            name: "Day20",
            dependencies: []),
        .testTarget(
            name: "Day20Tests",
            dependencies: ["Day20"]),
    ]
)
