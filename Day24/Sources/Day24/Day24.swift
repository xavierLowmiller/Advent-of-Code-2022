struct Position: Hashable {
    var x: Int
    var y: Int

    mutating func move(_ direction: Direction, min: Position, max: Position) {
        var next = self
        switch direction {
        case .up:
            next.y -= 1
            if next.y == min.y {
                next.y = max.y - 1
            }
        case .down:
            next.y += 1
            if next.y == max.y {
                next.y = min.y + 1
            }
        case .left:
            next.x -= 1
            if next.x == min.x {
                next.x = max.x - 1
            }
        case .right:
            next.x += 1
            if next.x == max.x {
                next.x = min.x + 1
            }
        }
        self = next
    }
}

enum Direction: CaseIterable {
    case up, down, left, right
}

func findWayThroughBlizzard(_ input: String) -> Int {
    let valley = BlizzardValley(input)
    let goal = valley.exit

    let path = bfs(
        start: valley,
        goal: { $0.position == goal },
        neighbors: \.neighbors
    )!

//    let path = aStar(
//        start: valley,
//        goal: { $0.position == goal },
//        cost: { $1.minute },
//        heuristic: { abs($0.position.x - goal.x) + abs($0.position.y - goal.y) + $0.minute },
//        neighbors: \.neighbors
//    )!

    print(path.map(\.description).joined(separator: "\n"))

    return path.count - 1
}

struct BlizzardValley {
    let min = Position(x: 0, y: 0)
    let max: Position
    let cycle: Int
    let exit: Position

    let initial = Position(x: 1, y: 0)
    var position = Position(x: 1, y: 0)
    private var index = 0
    private var blizzards: [Position: [Direction]]

    init(_ input: String) {
        blizzards = [:]
        var lastWall: Position!
        for (y, line) in input.split(separator: "\n").enumerated() {
            for (x, c) in line.enumerated() {
                let p = Position(x: x, y: y)
                switch c {
                case "#":
                    lastWall = p
                case ".":
                    break
                case ">":
                    blizzards[p, default: []].append(.right)
                case "<":
                    blizzards[p, default: []].append(.left)
                case "^":
                    blizzards[p, default: []].append(.up)
                case "v":
                    blizzards[p, default: []].append(.down)

                default:
                    fatalError("Unexpected Character \(c)")
                }
            }
        }
        max = lastWall
        exit = Position(x: lastWall.x - 1, y: lastWall.y)
        cycle = lcm(max.x - 1, max.y - 1)
    }

    mutating func step() {
        let oldBlizzards = blizzards
        blizzards = [:]
        for (p, bs) in oldBlizzards {
            for direction in bs {
                var position = p
                position.move(direction, min: min, max: max)
                blizzards[position, default: []].append(direction)
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

    private var possibleSteps: [Position] {
        var steps: [Position] = Direction.allCases.compactMap {
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
            }

            if p == exit { return p }

            guard min.x < p.x, p.x < max.x,
                  min.y < p.y, p.y < max.y,
                  blizzards[p]?.isEmpty ?? true
            else { return nil }
            return p
        }

        // Do nothing
        if blizzards[position]?.isEmpty ?? true {
            steps.append(position)
        }

        return steps
    }

    var description: String {
        var description = ""
        for y in min.y...max.y {
            for x in min.x...max.x {
                let p = Position(x: x, y: y)
                if p == position {
                    description.append("E")
                } else if p == initial || p == exit {
                    description.append(".")
                } else if p.x == min.x || p.x == max.x || p.y == min.y || p.y == max.y {
                    description.append("#")
                } else {
                    switch blizzards[p] {
                    case [], nil:
                        description.append(".")
                    case [.right]:
                        description.append(">")
                    case [.left]:
                        description.append("<")
                    case [.up]:
                        description.append("^")
                    case [.down]:
                        description.append("v")
                    case let b?:
                        description.append("\(b.count)")
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
        hasher.combine(position)
        hasher.combine(index)
    }
}

extension Optional where Wrapped == Direction {
    var description: String {
        switch self {
        case .up:
            return "move up"
        case .down:
            return "move down"
        case .left:
            return "move left"
        case .right:
            return "move right"
        case nil:
            return "wait"
        }
    }
}
