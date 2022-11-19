// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day8",
    products: [
        .library(
            name: "Day8",
            targets: ["Day8"]),
    ],
    targets: [
        .target(
            name: "Day8",
            dependencies: []),
        .testTarget(
            name: "Day8Tests",
            dependencies: ["Day8"]),
    ]
)
