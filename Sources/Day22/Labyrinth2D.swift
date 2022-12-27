public struct Labyrinth2D {
    struct Position: Hashable {
        var x: Int
        var y: Int
        
        func next(in direction: Direction, on tiles: Set<Self>, walls: Set<Self>) -> Position {
            var next = self
            switch direction {
            case .right:
                next.x += 1
            case .down:
                next.y += 1
            case .left:
                next.x -= 1
            case .top:
                next.y -= 1
            }
            
            if tiles.contains(next) {
                return next
            }
            
            if walls.contains(next) {
                return self
            }
            
            switch direction {
            case .right:
                next = tiles.filter({ $0.y == next.y }).min(by: { $0.x < $1.x })!
                if let nextWall = walls.filter({ $0.y == next.y }).min(by: { $0.x < $1.x }),
                   nextWall.x < next.x {
                    return self
                } else {
                    return next
                }
            case .down:
                next = tiles.filter({ $0.x == next.x }).min(by: { $0.y < $1.y })!
                if let nextWall = walls.filter({ $0.x == next.x }).min(by: { $0.y < $1.y }),
                   nextWall.y < next.y {
                    return self
                } else {
                    return next
                }
            case .left:
                next = tiles.filter({ $0.y == next.y }).max(by: { $0.x < $1.x })!
                if let nextWall = walls.filter({ $0.y == next.y }).max(by: { $0.x < $1.x }),
                   nextWall.x > next.x {
                    return self
                } else {
                    return next
                }
            case .top:
                next = tiles.filter({ $0.x == next.x }).max(by: { $0.y < $1.y })!
                if let nextWall = walls.filter({ $0.x == next.x }).max(by: { $0.y < $1.y }),
                   nextWall.y > next.y {
                    return self
                } else {
                    return next
                }
            }
        }
    }

    let tiles: Set<Position>
    let walls: Set<Position>
    var position: Position
    var direction: Direction = .right
    var instructions: [Instruction]

    public init(_ input: String) {
        tiles = Set(tiles: input.split(separator: "\n\n")[0])
        walls = Set(walls: input.split(separator: "\n\n")[0])
        var instructions = input.split(separator: "\n\n")[1]
        self.instructions = Array(&instructions)
        position = tiles.topLeft
    }

    public mutating func walk() {
        while !instructions.isEmpty {
            switch instructions.removeFirst() {
            case .moveForward(let steps):
                for _ in 0..<steps {
                    position = position.next(in: direction, on: tiles, walls: walls)
                }
            case .turnLeft:
                direction.turnLeft()
            case .turnRight:
                direction.turnRight()
            }
        }
    }

    public var score: Int {
        (position.y + 1) * 1000 + (position.x + 1) * 4 + direction.rawValue
    }
}

extension Set where Element == Labyrinth2D.Position {
    init(tiles: Substring) {
        let lines = tiles.split(separator: "\n")
        self = Set(minimumCapacity: tiles.count)
        for (y, line) in lines.enumerated() {
            for (x, c) in line.enumerated() {
                switch c {
                case " ":
                    break
                case "#":
                    break
                case ".":
                    insert(.init(x: x, y: y))
                default:
                    fatalError("Unexpected Character \(c)")
                }
            }
        }
    }

    init(walls: Substring) {
        let lines = walls.split(separator: "\n")
        self = Set(minimumCapacity: walls.count)
        for (y, line) in lines.enumerated() {
            for (x, c) in line.enumerated() {
                switch c {
                case " ":
                    break
                case "#":
                    insert(.init(x: x, y: y))
                case ".":
                    break
                default:
                    fatalError("Unexpected Character \(c)")
                }
            }
        }
    }

    var topLeft: Labyrinth2D.Position {
        filter { $0.y == 0 }.min(by: { $0.x < $1.y })!
    }
}
