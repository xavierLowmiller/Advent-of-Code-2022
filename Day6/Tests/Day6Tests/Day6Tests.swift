import XCTest
@testable import Day6

final class Day6Tests: XCTestCase {
    func testPart1Example() {
        let cases = [
            ("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7),
            ("bvwbjplbgvbhsrlpgdmjqwftvncz", 5),
            ("nppdvjthqldpwncqszvftbrmjlhg", 6),
            ("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10),
            ("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11)
        ]

        for c in cases {
            XCTAssertEqual(findBeginningOfPacket(c.0), c.1)
        }
    }

    func testPart2Example() {
        let cases = [
            ("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 19),
            ("bvwbjplbgvbhsrlpgdmjqwftvncz", 23),
            ("nppdvjthqldpwncqszvftbrmjlhg", 23),
            ("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 29),
            ("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 26)
        ]

        for c in cases {
            XCTAssertEqual(findBeginningOfMessage(c.0), c.1)
        }
    }

    func testDay6Part1() {
        let answer = findBeginningOfPacket(input)
        print("Day 6 Part 1:", answer)
    }

    func testDay6Part2() {
        let answer = findBeginningOfMessage(input)
        print("Day 6 Part 2:", answer)
    }
}
