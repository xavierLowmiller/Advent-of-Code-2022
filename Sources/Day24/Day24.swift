import AOCAlgorithms

struct Direction: OptionSet {
    var rawValue: UInt
    static let up = Direction(rawValue: 1 << 0)
    static let down = Direction(rawValue: 1 << 1)
    static let left = Direction(rawValue: 1 << 2)
    static let right = Direction(rawValue: 1 << 3)
    static let allCases = [Self.up, .down, .left, .right]
}

struct Position: Hashable {
    var x: Int
    var y: Int

    var neighbors: Set<Position> {
        [
            self,
            Position(x: x + 1, y: y),
            Position(x: x - 1, y: y),
            Position(x: x, y: y + 1),
            Position(x: x, y: y - 1),
        ]
    }
}

public func findWayThroughBlizzard(_ input: String) -> Int {
    let valley = BlizzardValley(input)
    let goal = valley.exit

    let path = bfs(
        start: valley,
        goal: { $0.position == goal },
        neighbors: \.neighbors
    )!

    return path.count - 1
}

public func findWayThroughBlizzardAndBack(_ input: String) -> Int {
    var valley = BlizzardValley(input)
    let start = valley.initial
    let goal = valley.exit

    let path1 = bfs(
        start: valley,
        goal: { $0.position == goal },
        neighbors: \.neighbors
    )!

    valley.round += path1.count - 1
    valley.position = goal
    valley.initial = goal
    valley.exit = start

    let path2 = bfs(
        start: valley,
        goal: { $0.position == start },
        neighbors: \.neighbors
    )!

    valley.round += path2.count - 1
    valley.position = start
    valley.initial = start
    valley.exit = goal

    let path3 = bfs(
        start: valley,
        goal: { $0.position == goal },
        neighbors: \.neighbors
    )!

    valley.round += path3.count - 1

    return valley.round
}

struct BlizzardValley {
    let min = Position(x: 0, y: 0)
    let max: Position
    let rounds: Int
    var exit: Position

    var initial = Position(x: 1, y: 0)
    var position = Position(x: 1, y: 0)
    var round = 0
    /// A map of the number of the round to the currently empty spots
    private let freeSpaces: [Int: Set<Position>]

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        var blizzards: [Position: Direction] = [:]
        for (y, line) in lines.enumerated() {
            for (x, c) in line.enumerated() {
                switch c {
                case "#", ".":
                    break
                case ">":
                    blizzards[Position(x: x, y: y)] = .right
                case "<":
                    blizzards[Position(x: x, y: y)] = .left
                case "^":
                    blizzards[Position(x: x, y: y)] = .up
                case "v":
                    blizzards[Position(x: x, y: y)] = .down

                default:
                    fatalError("Unexpected Character \(c)")
                }
            }
        }

        max = Position(x: lines[0].count - 1, y: lines.count - 1)
        exit = Position(x: max.x - 1, y: max.y)
        rounds = lcm(max.x + 1, max.y + 1)

        var freeSpaces: [Int: Set<Position>] = [:]
        for round in 0..<rounds {
            let oldBlizzards = blizzards
            blizzards = Dictionary(minimumCapacity: blizzards.count)
            for (position, bs) in oldBlizzards {
                for direction in Direction.allCases {
                    guard bs.contains(direction) else { continue }
                    var position = position
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
                    blizzards[position, default: []].insert(direction)
                }
            }
            freeSpaces[round] = emptySpots(in: blizzards, min: min, max: max)
                .union([exit, initial])
        }

        assert(freeSpaces.count == rounds)
        self.freeSpaces = freeSpaces
    }

    mutating func step() {
        round += 1
    }

    var neighbors: [BlizzardValley] {
        position.neighbors.intersection(freeSpaces[round % rounds]!).map {
            var valley = self
            valley.step()
            valley.position = $0
            return valley
        }
    }
}

private func emptySpots(in blizzards: [Position: Direction], min: Position, max: Position) -> Set<Position> {
    var set = Set<Position>(minimumCapacity: max.x * max.y)
    for x in (min.x + 1)..<max.x {
        for y in (min.y + 1)..<max.y {
            let p = Position(x: x, y: y)
            if !blizzards.keys.contains(p) {
                set.insert(p)
            }
        }
    }
    return set
}

extension BlizzardValley: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.position == rhs.position && lhs.round == rhs.round
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(position)
        hasher.combine(round)
    }
}
