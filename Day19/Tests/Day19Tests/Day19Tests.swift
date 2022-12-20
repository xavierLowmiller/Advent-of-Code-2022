import XCTest
@testable import Day19

final class Day19Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        Blueprint 1:
          Each ore robot costs 4 ore.
          Each clay robot costs 2 ore.
          Each obsidian robot costs 3 ore and 14 clay.
          Each geode robot costs 2 ore and 7 obsidian.

        Blueprint 2:
          Each ore robot costs 2 ore.
          Each clay robot costs 3 ore.
          Each obsidian robot costs 3 ore and 8 clay.
          Each geode robot costs 3 ore and 12 obsidian.
        """

        let answer = collectGeodesPart1(input)
        XCTAssertEqual(answer, 33)
    }

    func testPart2Example() {
        let input = """
        Blueprint 1:
          Each ore robot costs 4 ore.
          Each clay robot costs 2 ore.
          Each obsidian robot costs 3 ore and 14 clay.
          Each geode robot costs 2 ore and 7 obsidian.

        Blueprint 2:
          Each ore robot costs 2 ore.
          Each clay robot costs 3 ore.
          Each obsidian robot costs 3 ore and 8 clay.
          Each geode robot costs 3 ore and 12 obsidian.
        """

        let answer = collectGeodesPart2(input)
        XCTAssertEqual(answer, 56 * 62)
    }

    func testDay19Part1() {
        let answer = collectGeodesPart1(input)
        print("Day 19 Part 1:", answer)
    }

    func testDay19Part2() {
        let answer = collectGeodesPart2(input)
        print("Day 19 Part 2:", answer)
    }
}
