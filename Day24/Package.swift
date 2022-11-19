// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day24",
    products: [
        .library(
            name: "Day24",
            targets: ["Day24"]),
    ],
    targets: [
        .target(
            name: "Day24",
            dependencies: []),
        .testTarget(
            name: "Day24Tests",
            dependencies: ["Day24"]),
    ]
)
