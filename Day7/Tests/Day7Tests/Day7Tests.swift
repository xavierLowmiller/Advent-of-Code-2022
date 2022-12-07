import XCTest
@testable import Day7

final class Day7Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k
        """

        let tree = FileTree(input)
        let expected: FileTree =
            .directory("/", [
                .directory("a", [
                    .directory("e", [
                        .file("i", 584),
                    ]),
                    .file("f", 29116),
                    .file("g", 2557),
                    .file("h.lst", 62596),
                ]),
                .file("b.txt", 14848514),
                .file("c.dat", 8504156),
                .directory("d", [
                    .file("j", 4060174),
                    .file("d.log", 8033020),
                    .file("d.ext", 5626152),
                    .file("k", 7214296),
                ])
            ])

        XCTAssertEqual(tree, expected)
        XCTAssertEqual(tree.fileSizeSumForPart1, 95437)
    }

    func testPart2Example() {
        let input = """
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k
        """
        let tree = FileTree(input)
        XCTAssertEqual(tree.smallestDirectoryToDelete, 24933642)
    }

    func testDay7Part1() {
        let tree = FileTree(input)
        print("Day 7 Part 1:", tree.fileSizeSumForPart1)
    }

    func testDay7Part2() {
        let tree = FileTree(input)
        print("Day 7 Part 2:", tree.smallestDirectoryToDelete)
    }
}
