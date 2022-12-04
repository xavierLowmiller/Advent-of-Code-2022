// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day3",
    products: [
        .library(
            name: "Day3",
            targets: ["Day3"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Day3",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]),
        .testTarget(
            name: "Day3Tests",
            dependencies: ["Day3"]),
    ]
)
