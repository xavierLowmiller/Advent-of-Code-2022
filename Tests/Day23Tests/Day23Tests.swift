import XCTest
import Day23

final class Day23Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        ....#..
        ..###.#
        #...#.#
        .#...##
        #.###..
        ##.#.##
        .#..#..
        """

        var plantation = Plantation(input)
        XCTAssertEqual(plantation.description, """
        ....#..
        ..###.#
        #...#.#
        .#...##
        #.###..
        ##.#.##
        .#..#..

        """)
        plantation.performElvesAlgorithm()
        XCTAssertEqual(plantation.description, """
        .....#...
        ...#...#.
        .#..#.#..
        .....#..#
        ..#.#.##.
        #..#.#...
        #.#.#.##.
        .........
        ..#..#...

        """)
        plantation.performElvesAlgorithm()
        XCTAssertEqual(plantation.description, """
        ......#....
        ...#.....#.
        ..#..#.#...
        ......#...#
        ..#..#.#...
        #...#.#.#..
        ...........
        .#.#.#.##..
        ...#..#....

        """)
        plantation.performElvesAlgorithm()
        XCTAssertEqual(plantation.description, """
        ......#....
        ....#....#.
        .#..#...#..
        ......#...#
        ..#..#.#...
        #..#.....#.
        ......##...
        .##.#....#.
        ..#........
        ......#....

        """)
        plantation.performElvesAlgorithm()
        XCTAssertEqual(plantation.description, """
        ......#....
        .....#....#
        .#...##....
        ..#.....#.#
        ........#..
        #...###..#.
        .#......#..
        ...##....#.
        ...#.......
        ......#....

        """)
        plantation.performElvesAlgorithm()
        XCTAssertEqual(plantation.description, """
        ......#....
        ...........
        .#..#.....#
        ........#..
        .....##...#
        #.#.####...
        ..........#
        ...##..#...
        .#.........
        .........#.
        ...#..#....

        """)

        for _ in 5..<10 {
            plantation.performElvesAlgorithm()
        }

        XCTAssertEqual(plantation.description, """
        ......#.....
        ..........#.
        .#.#..#.....
        .....#......
        ..#.....#..#
        #......##...
        ....##......
        .#........#.
        ...#.#..#...
        ............
        ...#..#..#..

        """)

        XCTAssertEqual(plantation.emptySpaces, 110)
    }

    func testPart2Example() {
        let input = """
        ....#..
        ..###.#
        #...#.#
        .#...##
        #.###..
        ##.#.##
        .#..#..
        """

        var plantation = Plantation(input)
        let rounds = plantation.roundsUntilNoElfMoves()

        XCTAssertEqual(rounds, 20)
    }

    func testSingleRounds() {
        let input = """
        .....
        ..##.
        ..#..
        .....
        ..##.
        .....
        """

        var plantation = Plantation(input)
        for _ in 0..<10 {
            plantation.performElvesAlgorithm()
        }

        XCTAssertEqual(plantation.description, """
        ..#..
        ....#
        #....
        ....#
        .....
        ..#..

        """)
    }

    func testDay23Part1() {
        var plantation = Plantation(input)
        for _ in 0..<10 {
            plantation.performElvesAlgorithm()
        }
        print("Day 23 Part 1:", plantation.emptySpaces)
    }

    func testDay23Part2() {
        var plantation = Plantation(input)
        let rounds = plantation.roundsUntilNoElfMoves()
        print("Day 23 Part 2:", rounds)
    }
}
