// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day13",
    products: [
        .library(
            name: "Day13",
            targets: ["Day13"]),
    ],
    targets: [
        .target(
            name: "Day13",
            dependencies: []),
        .testTarget(
            name: "Day13Tests",
            dependencies: ["Day13"]),
    ]
)
