// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day25",
    products: [
        .library(
            name: "Day25",
            targets: ["Day25"]),
    ],
    targets: [
        .target(
            name: "Day25",
            dependencies: []),
        .testTarget(
            name: "Day25Tests",
            dependencies: ["Day25"]),
    ]
)
