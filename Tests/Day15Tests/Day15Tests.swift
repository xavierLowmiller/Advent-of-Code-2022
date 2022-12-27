import XCTest
@testable import Day15

final class Day15Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        Sensor at x=2, y=18: closest beacon is at x=-2, y=15
        Sensor at x=9, y=16: closest beacon is at x=10, y=16
        Sensor at x=13, y=2: closest beacon is at x=15, y=3
        Sensor at x=12, y=14: closest beacon is at x=10, y=16
        Sensor at x=10, y=20: closest beacon is at x=10, y=16
        Sensor at x=14, y=17: closest beacon is at x=10, y=16
        Sensor at x=8, y=7: closest beacon is at x=2, y=10
        Sensor at x=2, y=0: closest beacon is at x=2, y=10
        Sensor at x=0, y=11: closest beacon is at x=2, y=10
        Sensor at x=20, y=14: closest beacon is at x=25, y=17
        Sensor at x=17, y=20: closest beacon is at x=21, y=22
        Sensor at x=16, y=7: closest beacon is at x=15, y=3
        Sensor at x=14, y=3: closest beacon is at x=15, y=3
        Sensor at x=20, y=1: closest beacon is at x=15, y=3
        """

        let answer = numberOfPositionsThatCantContainABeacon(atLine: 10, input: input)

        XCTAssertEqual(answer, 26)
    }

    func testPart2Example() {
        let input = """
        Sensor at x=2, y=18: closest beacon is at x=-2, y=15
        Sensor at x=9, y=16: closest beacon is at x=10, y=16
        Sensor at x=13, y=2: closest beacon is at x=15, y=3
        Sensor at x=12, y=14: closest beacon is at x=10, y=16
        Sensor at x=10, y=20: closest beacon is at x=10, y=16
        Sensor at x=14, y=17: closest beacon is at x=10, y=16
        Sensor at x=8, y=7: closest beacon is at x=2, y=10
        Sensor at x=2, y=0: closest beacon is at x=2, y=10
        Sensor at x=0, y=11: closest beacon is at x=2, y=10
        Sensor at x=20, y=14: closest beacon is at x=25, y=17
        Sensor at x=17, y=20: closest beacon is at x=21, y=22
        Sensor at x=16, y=7: closest beacon is at x=15, y=3
        Sensor at x=14, y=3: closest beacon is at x=15, y=3
        Sensor at x=20, y=1: closest beacon is at x=15, y=3
        """

        let answer = onlyPossiblePosition(inRange: 20, input: input)

        XCTAssertEqual(answer.x, 14)
        XCTAssertEqual(answer.y, 11)
        XCTAssertEqual(answer.tuningFrequency, 56000011)
    }

    func testDay15Part1() {
        let answer = numberOfPositionsThatCantContainABeacon(atLine: 2000000, input: input)
        print("Day 15 Part 1:", answer)
    }

    func testDay15Part2() {
        let answer = onlyPossiblePosition(inRange: 4000000, input: input)
        print("Day 15 Part 2:", answer.tuningFrequency)
    }
}
