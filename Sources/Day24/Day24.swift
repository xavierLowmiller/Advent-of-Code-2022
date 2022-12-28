import AOCAlgorithms

struct Direction: OptionSet {
    var rawValue: UInt
    static let up = Direction(rawValue: 1 << 0)
    static let down = Direction(rawValue: 1 << 1)
    static let left = Direction(rawValue: 1 << 2)
    static let right = Direction(rawValue: 1 << 3)
    static let allCases = [Self.up, .down, .left, .right]
}

public func findWayThroughBlizzard(_ input: String) -> Int {
    let valley = BlizzardValley(input)
    let goal = valley.exit

    let path = bfs(
        start: valley,
        goal: { $0.position == goal },
        neighbors: \.neighbors
    )!

//    print(path.map(\.description).joined(separator: "\n"))

    return path.count - 1
}

struct BlizzardValley {
    let min = (x: 0, y: 0)
    let max: (x: Int, y: Int)
    let cycle: Int
    let exit: (x: Int, y: Int)

    let initial = (x: 1, y: 0)
    var position = (x: 1, y: 0)
    private var index = 0
    private var blizzards: [[Direction]]

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        blizzards = Array(repeating: Array(repeating: [], count: lines[0].count - 1), count: lines.count - 1)
        for (y, line) in lines.enumerated() {
            for (x, c) in line.enumerated() {
                switch c {
                case "#", ".":
                    break
                case ">":
                    blizzards[y][x].insert(.right)
                case "<":
                    blizzards[y][x].insert(.left)
                case "^":
                    blizzards[y][x].insert(.up)
                case "v":
                    blizzards[y][x].insert(.down)

                default:
                    fatalError("Unexpected Character \(c)")
                }
            }
        }
        max = (blizzards[0].count, blizzards.count)
        exit = (x: blizzards[0].count - 1, y: blizzards.count)
        cycle = lcm(blizzards.count, blizzards[0].count)
    }

    mutating func step() {
        let oldBlizzards = blizzards
        blizzards = Array(repeating: Array(repeating: [], count: blizzards[0].count), count: blizzards.count)
        for (y, line) in oldBlizzards.enumerated() {
            for (x, bs) in line.enumerated() {
                for direction in Direction.allCases {
                    guard bs.contains(direction) else { continue }
                    var position = (x: x, y: y)
                    switch direction {
                    case .up:
                        position.y -= 1
                        if position.y == min.y {
                            position.y = max.y - 1
                        }
                    case .down:
                        position.y += 1
                        if position.y == max.y {
                            position.y = min.y + 1
                        }
                    case .left:
                        position.x -= 1
                        if position.x == min.x {
                            position.x = max.x - 1
                        }
                    case .right:
                        position.x += 1
                        if position.x == max.x {
                            position.x = min.x + 1
                        }
                    default:
                        fatalError()
                    }
                    blizzards[position.y][position.x].insert(direction)
                }
            }
        }
        index = (index + 1) % cycle
    }

    var neighbors: [BlizzardValley] {
        var nextValley = self
        nextValley.step()
        return nextValley.possibleSteps.map { p in
            var valley = nextValley
            valley.position = p
            return valley
        }
    }

    private var possibleSteps: [(Int, Int)] {
        var steps: [(Int, Int)] = Direction.allCases.compactMap {
            var p = position
            switch $0 {
            case .up:
                p.y -= 1
            case .down:
                p.y += 1
            case .left:
                p.x -= 1
            case .right:
                p.x += 1
            default:
                fatalError()
            }

            if p == exit { return p }

            guard min.x < p.x, p.x < max.x,
                  min.y < p.y, p.y < max.y,
                  blizzards[p.y][p.x] == []
            else { return nil }
            return p
        }

        // Do nothing
        if blizzards[position.y][position.x] == [] {
            steps.append(position)
        }

        return steps
    }

    var description: String {
        var description = ""
        for y in min.y...max.y {
            for x in min.x...max.x {
                let p = (x: x, y: y)
                if p == position {
                    description.append("E")
                } else if p == initial || p == exit {
                    description.append(".")
                } else if p.x == min.x || p.x == max.x || p.y == min.y || p.y == max.y {
                    description.append("#")
                } else {
                    switch blizzards[y][x] {
                    case []:
                        description.append(".")
                    case .right:
                        description.append(">")
                    case .left:
                        description.append("<")
                    case .up:
                        description.append("^")
                    case .down:
                        description.append("v")
                    case let b:
                        description.append("\(b.rawValue.nonzeroBitCount)")
                    }
                }
            }
            description.append("\n")
        }
        return description
    }
}

extension BlizzardValley: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.position == rhs.position && lhs.index == rhs.index
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(position.x)
        hasher.combine(position.y)
        hasher.combine(index)
    }
}

extension Optional where Wrapped == Direction {
    var description: String {
        switch self {
        case .up?:
            return "move up"
        case .down?:
            return "move down"
        case .left?:
            return "move left"
        case .right?:
            return "move right"
        case nil:
            return "wait"
        default:
            fatalError()
        }
    }
}
