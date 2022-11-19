// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day4",
    products: [
        .library(
            name: "Day4",
            targets: ["Day4"]),
    ],
    targets: [
        .target(
            name: "Day4",
            dependencies: []),
        .testTarget(
            name: "Day4Tests",
            dependencies: ["Day4"]),
    ]
)
