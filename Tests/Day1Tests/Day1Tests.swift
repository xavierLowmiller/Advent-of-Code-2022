import XCTest
import Day1

final class Day1Tests: XCTestCase {
    func testExamplePart1() {
        let input = """
        1000
        2000
        3000

        4000

        5000
        6000

        7000
        8000
        9000

        10000
        """

        let elfWithMostCalories = elfWithMostCalories(input)

        XCTAssertEqual(elfWithMostCalories, 24000)
    }

    func testExamplePart2() {
        let input = """
        1000
        2000
        3000

        4000

        5000
        6000

        7000
        8000
        9000

        10000
        """

        let elfWithMostCalories = elvesWithTopThreeCalories(input)

        XCTAssertEqual(elfWithMostCalories, 45000)
    }

    func testDay1Part1() {
        print("Day 1 Part 1:", elfWithMostCalories(input))
    }

    func testDay1Part2() {
        print("Day 1 Part 2:", elvesWithTopThreeCalories(input))
    }
}
