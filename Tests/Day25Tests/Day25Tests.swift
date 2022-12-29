import XCTest
import Day25

final class Day25Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        1=-0-2
        12111
        2=0=
        21
        2=01
        111
        20012
        112
        1=-1=
        1-12
        12
        1=
        122
        """

        XCTAssertEqual(snafuSum(input), "2=-1=0")

        let pairs = [
            ("1=-0-2", 1747),
            ("12111", 906),
            ("2=0=", 198),
            ("21", 11),
            ("2=01", 201),
            ("111", 31),
            ("20012", 1257),
            ("112", 32),
            ("1=-1=", 353),
            ("1-12", 107),
            ("12", 7),
            ("1=", 3),
            ("122", 37)
        ]

        for pair in pairs {
            XCTAssertEqual(translate(pair.0), pair.1)
            XCTAssertEqual(translate(pair.1), pair.0)
        }
    }

    func testDay25Part1() {
        print("Day 25 Part 1:", snafuSum(input))
    }
}
