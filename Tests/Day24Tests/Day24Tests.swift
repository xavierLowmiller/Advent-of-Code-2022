import XCTest
import Day24

final class Day24Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        #.######
        #>>.<^<#
        #.<..<<#
        #>v.><>#
        #<^v^^>#
        ######.#
        """

        let answer = findWayThroughBlizzard(input)
        XCTAssertEqual(answer, 18)
    }

    func testDay24Part1() { 
        let answer = findWayThroughBlizzard(input)
        print("Day 24 Part 1:", answer)
    }

    func testDay24Part2() {
        print("Day 24 Part 2:")
    }
}
