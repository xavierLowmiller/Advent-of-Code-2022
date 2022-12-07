// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Day7",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "Day7",
            targets: ["Day7"]),
    ],
    targets: [
        .target(
            name: "Day7",
            dependencies: []),
        .testTarget(
            name: "Day7Tests",
            dependencies: ["Day7"]),
    ]
)
