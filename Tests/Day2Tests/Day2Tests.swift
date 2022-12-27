import XCTest
@testable import Day2

final class Day2Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        A Y
        B X
        C Z
        """

        let rps = RPSGame(input, isPart1: true)
        let score = rps.calculateScore()
        XCTAssertEqual(score, 15)
    }

    func testPart2Example() {
        let input = """
        A Y
        B X
        C Z
        """

        let rps = RPSGame(input, isPart1: false)
        let score = rps.calculateScore()
        XCTAssertEqual(score, 12)
    }

    func testDay2Part1() {
        let rps = RPSGame(input, isPart1: true)
        let score = rps.calculateScore()
        print("Day 2 Part 1:", score)
    }

    func testDay2Part2() {
        let rps = RPSGame(input, isPart1: false)
        let score = rps.calculateScore()
        print("Day 2 Part 2:", score)
    }
}
