import XCTest
import Day21

final class Day21Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        root: pppw + sjmn
        dbpl: 5
        cczh: sllz + lgvd
        zczc: 2
        ptdq: humn - dvpt
        dvpt: 3
        lfqf: 4
        humn: 5
        ljgn: 2
        sjmn: drzm * dbpl
        sllz: 4
        pppw: cczh / lfqf
        lgvd: ljgn * ptdq
        drzm: hmdt - zczc
        hmdt: 32
        """

        let answer = solveRiddle1(input)
        XCTAssertEqual(answer, 152)
    }

    func testPart2Example() {
        let input = """
        root: pppw + sjmn
        dbpl: 5
        cczh: sllz + lgvd
        zczc: 2
        ptdq: humn - dvpt
        dvpt: 3
        lfqf: 4
        humn: 5
        ljgn: 2
        sjmn: drzm * dbpl
        sllz: 4
        pppw: cczh / lfqf
        lgvd: ljgn * ptdq
        drzm: hmdt - zczc
        hmdt: 32
        """

        let answer = solveRiddle2(input)
        XCTAssertEqual(answer, 301)
    }

    func testDay21Part1() {
        let answer = solveRiddle1(input)
        print("Day 21 Part 1:", answer)
    }

    func testDay21Part2() {
        let answer = solveRiddle2(input)
        print("Day 21 Part 2:", answer)
    }
}
