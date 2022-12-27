import XCTest
@testable import Day11

final class Day11Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        Monkey 0:
          Starting items: 79, 98
          Operation: new = old * 19
          Test: divisible by 23
            If true: throw to monkey 2
            If false: throw to monkey 3

        Monkey 1:
          Starting items: 54, 65, 75, 74
          Operation: new = old + 6
          Test: divisible by 19
            If true: throw to monkey 2
            If false: throw to monkey 0

        Monkey 2:
          Starting items: 79, 60, 97
          Operation: new = old * old
          Test: divisible by 13
            If true: throw to monkey 1
            If false: throw to monkey 3

        Monkey 3:
          Starting items: 74
          Operation: new = old + 3
          Test: divisible by 17
            If true: throw to monkey 0
            If false: throw to monkey 1
        """

        let answer = playMonkeyGame(input: input, rounds: 20, mode: .part1)

        XCTAssertEqual(answer, 10605)
    }

    func testDay11Part1() {
        let answer = playMonkeyGame(input: input, rounds: 20, mode: .part1)
        print("Day 11 Part 1:", answer)
    }

    func testPart2Example() {
        let input = """
        Monkey 0:
          Starting items: 79, 98
          Operation: new = old * 19
          Test: divisible by 23
            If true: throw to monkey 2
            If false: throw to monkey 3

        Monkey 1:
          Starting items: 54, 65, 75, 74
          Operation: new = old + 6
          Test: divisible by 19
            If true: throw to monkey 2
            If false: throw to monkey 0

        Monkey 2:
          Starting items: 79, 60, 97
          Operation: new = old * old
          Test: divisible by 13
            If true: throw to monkey 1
            If false: throw to monkey 3

        Monkey 3:
          Starting items: 74
          Operation: new = old + 3
          Test: divisible by 17
            If true: throw to monkey 0
            If false: throw to monkey 1
        """

        let answer = playMonkeyGame(input: input, rounds: 10000, mode: .part2)

        XCTAssertEqual(answer, 2713310158)
    }

    func testDay11Part2() {
        let answer = playMonkeyGame(input: input, rounds: 10000, mode: .part2)
        print("Day 11 Part 2:", answer)
    }
}
