import XCTest
@testable import Day12

final class Day12Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        Sabqponm
        abcryxxl
        accszExk
        acctuvwj
        abdefghi
        """

        let answer = leastAmountOfStepsPart1(input)

        XCTAssertEqual(answer, 31)
    }

    func testPart2Example() {
        let input = """
        Sabqponm
        abcryxxl
        accszExk
        acctuvwj
        abdefghi
        """

        let answer = leastAmountOfStepsPart2(input)

        XCTAssertEqual(answer, 29)
    }

    func testDay12Part1() {
        let answer = leastAmountOfStepsPart1(input)
        print("Day 12 Part 1:", answer)
    }

    func testDay12Part2() {
        let answer = leastAmountOfStepsPart2(input)
        print("Day 12 Part 2:", answer)
    }
}
