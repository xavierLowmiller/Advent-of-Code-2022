import XCTest
@testable import Day8

final class Day8Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        30373
        25512
        65332
        33549
        35390
        """

        let grid = TreeGrid(input)

        XCTAssertEqual(grid.amountOfVisibleTrees, 21)
    }

    func testPart2Example() {
        let input = """
        30373
        25512
        65332
        33549
        35390
        """

        let grid = TreeGrid(input)

        XCTAssertEqual(grid.highestScenicScore, 8)
    }

    func testDay8Part1() {
        let grid = TreeGrid(input)
        print("Day 8 Part 1:", grid.amountOfVisibleTrees)
    }

    func testDay8Part2() {
        let grid = TreeGrid(input)
        print("Day 8 Part 2:", grid.highestScenicScore)
    }
}
