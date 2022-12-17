// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Day16",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "Day16",
            targets: ["Day16"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-identified-collections.git", .upToNextMajor(from: "0.5.0")),
    ],
    targets: [
        .target(
            name: "Day16",
            dependencies: [
                .product(name: "IdentifiedCollections", package: "swift-identified-collections")
            ]),
        .testTarget(
            name: "Day16Tests",
            dependencies: ["Day16"]),
    ]
)
