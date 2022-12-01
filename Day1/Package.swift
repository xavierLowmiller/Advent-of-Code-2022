// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day1",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "Day1",
            targets: ["Day1"]),
    ],
    targets: [
        .target(
            name: "Day1",
            dependencies: []),
        .testTarget(
            name: "Day1Tests",
            dependencies: ["Day1"]),
    ]
)
