import XCTest
@testable import Day13

final class Day13Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        [1,1,3,1,1]
        [1,1,5,1,1]

        [[1],[2,3,4]]
        [[1],4]

        [9]
        [[8,7,6]]

        [[4,4],4,4]
        [[4,4],4,4,4]

        [7,7,7,7]
        [7,7,7]

        []
        [3]

        [[[]]]
        [[]]

        [1,[2,[3,[4,[5,6,7]]]],8,9]
        [1,[2,[3,[4,[5,6,0]]]],8,9]
        """

        let answer = scoreOfPairsInTheRightOrder(input)
        XCTAssertEqual(answer, 13)
    }

    func testPart2Example() {
        let input = """
        [1,1,3,1,1]
        [1,1,5,1,1]

        [[1],[2,3,4]]
        [[1],4]

        [9]
        [[8,7,6]]

        [[4,4],4,4]
        [[4,4],4,4,4]

        [7,7,7,7]
        [7,7,7]

        []
        [3]

        [[[]]]
        [[]]

        [1,[2,[3,[4,[5,6,7]]]],8,9]
        [1,[2,[3,[4,[5,6,0]]]],8,9]
        """

        let answer = decoderKey(input)
        XCTAssertEqual(answer, 140)
    }

    func testDay13Part1() {
        let answer = scoreOfPairsInTheRightOrder(input)
        print("Day 13 Part 1:", answer)
    }

    func testDay13Part2() {
        let answer = decoderKey(input)
        print("Day 13 Part 2:", answer)
    }
}
