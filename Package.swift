// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "Day1", targets: ["Day1"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-identified-collections.git", .upToNextMajor(from: "0.5.0")),
        .package(url: "https://github.com/apple/swift-algorithms.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(name: "AOCAlgorithms", dependencies: [
            .product(name: "DequeModule", package: "swift-collections"),
        ]),
        .testTarget(name: "AOCAlgorithmsTests", dependencies: ["AOCAlgorithms"]),
        .target(name: "Day1"),
        .testTarget(name: "Day1Tests", dependencies: ["Day1"]),
        .target(name: "Day2"),
        .testTarget(name: "Day2Tests", dependencies: ["Day2"]),
        .target(name: "Day3", dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms")
        ]),
        .testTarget(name: "Day3Tests", dependencies: ["Day3"]),
        .target(name: "Day4"),
        .testTarget(name: "Day4Tests", dependencies: ["Day4"]),
        .target(name: "Day5"),
        .testTarget(name: "Day5Tests", dependencies: ["Day5"]),
        .target(name: "Day6"),
        .testTarget(name: "Day6Tests", dependencies: ["Day6"]),
        .target(name: "Day7"),
        .testTarget(name: "Day7Tests", dependencies: ["Day7"]),
        .target(name: "Day8"),
        .testTarget(name: "Day8Tests", dependencies: ["Day8"]),
        .target(name: "Day9"),
        .testTarget(name: "Day9Tests", dependencies: ["Day9"]),
        .target(name: "Day10"),
        .testTarget(name: "Day10Tests", dependencies: ["Day10"]),
        .target(name: "Day11"),
        .testTarget(name: "Day11Tests", dependencies: ["Day11"]),
        .target(name: "Day12", dependencies: ["AOCAlgorithms"]),
        .testTarget(name: "Day12Tests", dependencies: ["Day12"]),
        .target(name: "Day13"),
        .testTarget(name: "Day13Tests", dependencies: ["Day13"]),
        .target(name: "Day14"),
        .testTarget(name: "Day14Tests", dependencies: ["Day14"]),
        .target(name: "Day15"),
        .testTarget(name: "Day15Tests", dependencies: ["Day15"]),
        .target(name: "Day16", dependencies: [
            .product(name: "IdentifiedCollections", package: "swift-identified-collections"),
        ]),
        .testTarget(name: "Day16Tests", dependencies: ["Day16"]),
        .target(name: "Day17"),
        .testTarget(name: "Day17Tests", dependencies: ["Day17"]),
        .target(name: "Day18"),
        .testTarget(name: "Day18Tests", dependencies: ["Day18"]),
        .target(name: "Day19"),
        .testTarget(name: "Day19Tests", dependencies: ["Day19"]),
        .target(name: "Day20", dependencies: ["AOCAlgorithms"]),
        .testTarget(name: "Day20Tests", dependencies: ["Day20"]),
        .target(name: "Day21"),
        .testTarget(name: "Day21Tests", dependencies: ["Day21"]),
        .target(name: "Day22"),
        .testTarget(name: "Day22Tests", dependencies: ["Day22"]),
        .target(name: "Day23"),
        .testTarget(name: "Day23Tests", dependencies: ["Day23"]),
        .target(name: "Day24", dependencies: ["AOCAlgorithms"]),
        .testTarget(name: "Day24Tests", dependencies: ["Day24"]),
        .target(name: "Day25"),
        .testTarget(name: "Day25Tests", dependencies: ["Day25"]),
    ]
)
