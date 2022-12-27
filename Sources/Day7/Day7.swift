import Foundation

public enum FileTree: Equatable {
    case directory(_ name: String, [FileTree])
    case file(_ name: String, _ size: Int)

    public init(_ input: String) {
        var terminal = Terminal()
        for command in input.split(separator: "$ ") {
            terminal.executeCommand(command)
        }

        self = terminal.tree
    }

    var size: Int {
        switch self {
        case .directory(_, let contents):
            return contents.map(\.size).reduce(0, +)
        case .file(_, let size):
            return size
        }
    }

    public var fileSizeSumForPart1: Int {
        let maxSize = 100000
        return directories.map(\.size).filter { $0 < maxSize }.reduce(0, +)
    }

    public var smallestDirectoryToDelete: Int {
        let spaceThatNeedsToBeDeleted = size - (70000000 - 30000000)
        return directories.map(\.size)
            .filter { $0 > spaceThatNeedsToBeDeleted }
            .min()!
    }

    private var directories: [FileTree] {
        switch self {
        case .directory(_, let contents):
            return [self] + contents.flatMap(\.directories)
        case .file:
            return []
        }
    }
}

private struct Terminal {
    var dir: [String] = []
    var contents: [String: [FileTree]] = [:]

    mutating func executeCommand(_ command: Substring) {
        if command.hasPrefix("ls") { ls(command) }
        if command.hasPrefix("cd") { cd(command) }
    }

    private mutating func cd(_ directory: Substring) {
        let directory = directory.split(separator: " ").last!.trimmingCharacters(in: .whitespacesAndNewlines)
        if directory == ".." {
            dir.removeLast()
        } else {
            dir.append(String(directory))
        }
    }

    private mutating func ls(_ input: Substring) {
        let path = dir.joined(separator: "/")
        assert(contents[path] == nil)
        contents[path] = input.split(separator: "\n").compactMap {
            if let fileMatch = $0.wholeMatch(of: #/(\d+) ([\w.]*)/#) {
                return .file(String(fileMatch.2), Int(fileMatch.1)!)
            } else if let dirMatch = $0.wholeMatch(of: #/dir (\w)/#) {
                return .directory(String(dirMatch.1), [])
            } else {
                return nil
            }
        }
    }

    var tree: FileTree {
        contents.tree(for: "/", path: "/")
    }
}

private extension Dictionary where Key == String, Value == [FileTree] {
    func tree(for key: String, path: String) -> FileTree {
        .directory(key, self[path]!.map {
            if case let .directory(name, _) = $0 {
                return tree(for: name, path: path + "/" + name)
            } else {
                return $0
            }
        })
    }
}
