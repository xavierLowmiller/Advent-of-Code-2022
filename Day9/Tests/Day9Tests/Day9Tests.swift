import XCTest
@testable import Day9

final class Day9Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        R 4
        U 4
        L 3
        D 1
        R 4
        D 1
        L 5
        R 2
        """

        XCTAssertEqual(numberOfPositionsTouchedByTail(input), 13)
    }

    func testPart2Example() {
        let input = """
        R 5
        U 8
        L 8
        D 3
        R 17
        D 10
        L 25
        U 20
        """

        XCTAssertEqual(numberOfPositionsTouchedByLastKnot(input), 36)
    }

    func testDay9Part1() {
        let answer = numberOfPositionsTouchedByTail(input)
        print("Day 9 Part 1:", answer)
    }

    func testDay9Part2() {
        let answer = numberOfPositionsTouchedByLastKnot(input)
        print("Day 9 Part 2:", answer)
    }
}
