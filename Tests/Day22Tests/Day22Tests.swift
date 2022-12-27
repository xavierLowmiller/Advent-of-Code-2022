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

        var labyrinth = Labyrinth2D(input)
        labyrinth.walk()
        XCTAssertEqual(labyrinth.score, 6032)
    }

    func testPart2Example() {
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

//        var labyrinth = Labyrinth3D(input)
//        labyrinth.walk()
//        XCTAssertEqual(labyrinth.score, 5031)
    }

    func testDay22Part1() {
        var labyrinth = Labyrinth2D(input)
        labyrinth.walk()
        print("Day 22 Part 1:", labyrinth.score)
    }

    func testDay22Part2() {
//        var labyrinth = Labyrinth3D(input)
//        labyrinth.walk()
//        print("Day 22 Part 2:", labyrinth.score)
    }
}
