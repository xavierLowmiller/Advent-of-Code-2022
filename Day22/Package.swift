// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day22",
    products: [
        .library(
            name: "Day22",
            targets: ["Day22"]),
    ],
    targets: [
        .target(
            name: "Day22",
            dependencies: []),
        .testTarget(
            name: "Day22Tests",
            dependencies: ["Day22"]),
    ]
)
