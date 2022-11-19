// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day19",
    products: [
        .library(
            name: "Day19",
            targets: ["Day19"]),
    ],
    targets: [
        .target(
            name: "Day19",
            dependencies: []),
        .testTarget(
            name: "Day19Tests",
            dependencies: ["Day19"]),
    ]
)
