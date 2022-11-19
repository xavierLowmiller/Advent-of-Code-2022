// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day3",
    products: [
        .library(
            name: "Day3",
            targets: ["Day3"]),
    ],
    targets: [
        .target(
            name: "Day3",
            dependencies: []),
        .testTarget(
            name: "Day3Tests",
            dependencies: ["Day3"]),
    ]
)
