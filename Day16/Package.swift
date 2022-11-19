// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day16",
    products: [
        .library(
            name: "Day16",
            targets: ["Day16"]),
    ],
    targets: [
        .target(
            name: "Day16",
            dependencies: []),
        .testTarget(
            name: "Day16Tests",
            dependencies: ["Day16"]),
    ]
)
