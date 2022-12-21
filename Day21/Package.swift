// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day21",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "Day21",
            targets: ["Day21"]),
    ],
    targets: [
        .target(
            name: "Day21",
            dependencies: []),
        .testTarget(
            name: "Day21Tests",
            dependencies: ["Day21"]),
    ]
)
