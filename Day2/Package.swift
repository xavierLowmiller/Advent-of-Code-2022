// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day2",
    products: [
        .library(
            name: "Day2",
            targets: ["Day2"]),
    ],
    targets: [
        .target(
            name: "Day2",
            dependencies: []),
        .testTarget(
            name: "Day2Tests",
            dependencies: ["Day2"]),
    ]
)
