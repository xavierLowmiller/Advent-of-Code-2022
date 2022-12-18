import XCTest
@testable import Day18

final class Day18Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(surfaceOfLavaDroplet("1,1,1\n2,1,1"), 10)

        let input = """
        2,2,2
        1,2,2
        3,2,2
        2,1,2
        2,3,2
        2,2,1
        2,2,3
        2,2,4
        2,2,6
        1,2,5
        3,2,5
        2,1,5
        2,3,5
        """

        XCTAssertEqual(surfaceOfLavaDroplet(input), 64)
    }

    func testPart2Example() {
        let input = """
        2,2,2
        1,2,2
        3,2,2
        2,1,2
        2,3,2
        2,2,1
        2,2,3
        2,2,4
        2,2,6
        1,2,5
        3,2,5
        2,1,5
        2,3,5
        """

        XCTAssertEqual(surfaceOfLavaDropletWithoutContainedAir(input), 58)
    }

    func testDay18Part1() {
        let answer = surfaceOfLavaDroplet(input)
        print("Day 18 Part 1:", answer)
    }

    func testDay18Part2() {
        let answer = surfaceOfLavaDropletWithoutContainedAir(input)
        print("Day 18 Part 2:", answer)
    }
}
