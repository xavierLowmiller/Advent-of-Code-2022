import XCTest
import Day22

final class Day22Tests: XCTestCase {
    func testPart1Example() {
        let input = """
                ...#
                .#..
                #...
                ....
        ...#.......#
        ........#...
        ..#....#....
        ..........#.
                ...#....
                .....#..
                .#......
                ......#.

        10R5L5R10L4R5L5
        """

        var labyrinth = Labyrinth2D(input, isPart2: false)
        labyrinth.walk()
        XCTAssertEqual(labyrinth.score, 6032)
    }

    func testDay22Part1() {
        var labyrinth = Labyrinth2D(input, isPart2: false)
        labyrinth.walk()
        print("Day 22 Part 1:", labyrinth.score)
    }

    func testDay22Part2() {
        var labyrinth = Labyrinth2D(input, isPart2: true)
        labyrinth.walk()
        print("Day 22 Part 2:", labyrinth.score)
    }

    func testInversionOfNumbers() {
        XCTAssertEqual(1.inverted(along: 25), 23)
        XCTAssertEqual(3.inverted(along: 25), 21)
        XCTAssertEqual(23.inverted(along: 25), 1)
        XCTAssertEqual(12.inverted(along: 25), 12)
        XCTAssertEqual(49.inverted(along: 50), 0)
        XCTAssertEqual(49.inverted(along: 100), 50)
        XCTAssertEqual(1.inverted(along: 100), 98)
    }
}
