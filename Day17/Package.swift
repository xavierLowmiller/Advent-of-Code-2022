// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day17",
    products: [
        .library(
            name: "Day17",
            targets: ["Day17"]),
    ],
    targets: [
        .target(
            name: "Day17",
            dependencies: []),
        .testTarget(
            name: "Day17Tests",
            dependencies: ["Day17"]),
    ]
)
