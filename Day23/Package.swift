// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day23",
    products: [
        .library(
            name: "Day23",
            targets: ["Day23"]),
    ],
    targets: [
        .target(
            name: "Day23",
            dependencies: []),
        .testTarget(
            name: "Day23Tests",
            dependencies: ["Day23"]),
    ]
)
