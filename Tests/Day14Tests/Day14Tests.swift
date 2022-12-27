import XCTest
import Day14

final class Day14Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        498,4 -> 498,6 -> 496,6
        503,4 -> 502,4 -> 502,9 -> 494,9
        """

        let answer = amountOfSandTheStructureCanHold(input)
        XCTAssertEqual(answer, 24)
    }

    func testPart2Example() {
        let input = """
        498,4 -> 498,6 -> 496,6
        503,4 -> 502,4 -> 502,9 -> 494,9
        """

        let answer = amountOfSandTheStructureCanHold(input, withFloor: true)
        XCTAssertEqual(answer, 93)
    }

    func testDay14Part1() {
        let answer = amountOfSandTheStructureCanHold(input)
        print("Day 14 Part 1:", answer)
    }

    func testDay14Part2() {
        let answer = amountOfSandTheStructureCanHold(input, withFloor: true)
        print("Day 14 Part 2:", answer)
    }
}
