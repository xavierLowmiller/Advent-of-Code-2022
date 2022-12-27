import XCTest
import Day5

final class Day5Tests: XCTestCase {
    func testPart1Example() {
        let input = """
            [D]
        [N] [C]
        [Z] [M] [P]
         1   2   3

        move 1 from 2 to 1
        move 3 from 1 to 3
        move 2 from 2 to 1
        move 1 from 1 to 2
        """

        var crane = Crane(input, part: .part1)
        crane.executeInstructions()
        XCTAssertEqual(crane.topCrates, "CMZ")
    }

    func testPart2Example() {
        let input = """
            [D]
        [N] [C]
        [Z] [M] [P]
         1   2   3

        move 1 from 2 to 1
        move 3 from 1 to 3
        move 2 from 2 to 1
        move 1 from 1 to 2
        """

        var crane = Crane(input, part: .part2)
        crane.executeInstructions()
        XCTAssertEqual(crane.topCrates, "MCD")
    }

    func testDay5Part1() {
        var crane = Crane(input, part: .part1)
        crane.executeInstructions()
        print("Day 5 Part 1:", crane.topCrates)
    }

    func testDay5Part2() {
        var crane = Crane(input, part: .part2)
        crane.executeInstructions()
        print("Day 5 Part 2:", crane.topCrates)
    }
}
