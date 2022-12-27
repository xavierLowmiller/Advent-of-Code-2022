import XCTest
import Day3

final class Day3Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
        """

        let answer = sumOfPrioritiesOfItemInBothCompartments(input: input)

        XCTAssertEqual(answer, 157)
    }

    func testPart2Example() {
        let input = """
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
        """

        let answer = sumOfPrioritiesOfElfBadges(input: input)

        XCTAssertEqual(answer, 70)
    }

    func testDay3Part1() {
        let answer = sumOfPrioritiesOfItemInBothCompartments(input: input)

        print("Day 3 Part 1:", answer)
    }
    func testDay3Part2() {
        let answer = sumOfPrioritiesOfElfBadges(input: input)

        print("Day 3 Part 2:", answer)
    }
}
