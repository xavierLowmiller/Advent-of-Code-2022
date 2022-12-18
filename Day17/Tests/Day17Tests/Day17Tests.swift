import XCTest
@testable import Day17

final class Day17Tests: XCTestCase {

    func testPart1Example() {
        let input = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

        let answer = simulateFallingRocks(input, amount: 2022)
        XCTAssertEqual(answer, 3068)
    }

    func testPart2Example() {
        let input = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

        let answer = simulateFallingRocks(input, amount: 1000000000000)
        XCTAssertEqual(answer, 1514285714288)
    }

    func testDay17Part1() {
        let answer = simulateFallingRocks(input, amount: 2022)
        print("Day 17 Part 1:", answer)
    }

    func testDay17Part2() {
        let answer = simulateFallingRocks(input, amount: 1000000000000)
        print("Day 17 Part 2:", answer)
    }
}
