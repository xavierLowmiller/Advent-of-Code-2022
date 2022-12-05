// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day5",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "Day5",
            targets: ["Day5"]),
    ],
    targets: [
        .target(
            name: "Day5",
            dependencies: []),
        .testTarget(
            name: "Day5Tests",
            dependencies: ["Day5"]),
    ]
)
