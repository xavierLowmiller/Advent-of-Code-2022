import XCTest
import Day20

final class Day20Tests: XCTestCase {

    func testPart1Example() {
        let input = """
        1
        2
        -3
        3
        -2
        0
        4
        """

        var decryption = Decryption(input, isPart2: false)
        decryption.mix()
        let answer = decryption.score

        XCTAssertEqual(answer, 3)
    }

    func testPart2Example() {
        let input = """
        1
        2
        -3
        3
        -2
        0
        4
        """

        var decryption = Decryption(input, isPart2: true)
        decryption.mix()
        let answer = decryption.score

        XCTAssertEqual(answer, 1623178306)
    }

    func testDay20Part1() {
        var decryption = Decryption(input, isPart2: false)
        decryption.mix()

        print("Day 20 Part 1:", decryption.score)
    }

    func testDay20Part2() {
        var decryption = Decryption(input, isPart2: true)
        decryption.mix()

        print("Day 20 Part 2:", decryption.score)
    }
}
