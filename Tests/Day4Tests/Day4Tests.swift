import XCTest
import Day4

final class Day4Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
        """

        let overlaps = totalOverlaps(of: input)

        XCTAssertEqual(overlaps, 2)
    }

    func testPart2Example() {
        let input = """
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
        """

        let overlaps = partialOverlaps(of: input)

        XCTAssertEqual(overlaps, 4)
    }


    func testDay4Part1() {
        let overlaps = totalOverlaps(of: input)

        print("Day 4 Part 1:", overlaps)
    }

    func testDay4Part2() {
        let overlaps = partialOverlaps(of: input)

        print("Day 4 Part 2:", overlaps)
    }
}
