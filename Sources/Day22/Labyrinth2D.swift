import AOCAlgorithms

public struct Labyrinth2D {
    struct Position: Hashable {
        var x: Int
        var y: Int

        func next(in direction: Direction) -> Position {
            var next = self
            switch direction {
            case .right:
                next.x += 1
            case .down:
                next.y += 1
            case .left:
                next.x -= 1
            case .up:
                next.y -= 1
            }
            return next
        }
    }

    let tiles: Set<Position>
    let walls: Set<Position>
    let isPart2: Bool
    let sideLength: Int

    var position: Position
    var direction: Direction = .right
    var instructions: [Instruction]

    public init(_ input: String, isPart2: Bool) {
        walls = Set(walls: input.split(separator: "\n\n")[0])
        tiles = Set(tiles: input.split(separator: "\n\n")[0])
        var instructions = input.split(separator: "\n\n")[1]
        self.instructions = Array(&instructions)

        sideLength = (tiles.count / 6).squareRoot()
        position = tiles.topLeft
        self.isPart2 = isPart2
    }

    public mutating func walk() {
        while !instructions.isEmpty {
            switch instructions.removeFirst() {
            case .moveForward(let steps):
                for _ in 0..<steps {
                    moveForward(isPart2: isPart2)
                }
            case .turnLeft:
                direction.turnLeft()
            case .turnRight:
                direction.turnRight()
            }
        }
    }

    private mutating func moveForward(isPart2: Bool) {
        let next = position.next(in: direction)

        if walls.contains(next) {
            return
        } else if tiles.contains(next) {
            position = next
            return
        } else {
            if isPart2 {
                let (position, direction) = wrapAround3D(next: next)
                if walls.contains(position) {
                    return
                } else {
                    self.position = position
                    self.direction = direction
                }
            } else {
                position = wrapAround2D(next: next)
            }
        }
    }

    /// Wraps the position around the 3D shape
    ///
    /// This only works with the shape of my input, which is this:
    ///
    /// ```
    /// ▫️◼️◼️
    /// ▫️◼️▫️
    /// ◼️◼️▫️
    /// ◼️▫️▫️
    /// ```
    ///
    private func wrapAround3D(next p: Position) -> (Position, Direction) {
        var next = p
        var direction = direction
        switch direction {
        // 1st row
        case .right where next.x == sideLength * 3 && (0..<sideLength) ~= next.y:
            next = Position(
                x: 2 * sideLength - 1,
                y: next.y.inverted(along: sideLength) + 2 * sideLength
            )
            direction = .left

        case .left where next.x == sideLength - 1 && (0..<sideLength) ~= next.y:
            next = Position(
                x: 0,
                y: next.y.inverted(along: sideLength) + 2 * sideLength
            )
            direction = .right

        case .up where (sideLength..<(2 * sideLength)) ~= next.x && next.y == -1:
            next = Position(
                x: 0,
                y: next.x + 2 * sideLength
            )
            direction = .right

        case .up where ((2 * sideLength)..<(3 * sideLength)) ~= next.x && next.y == -1:
            next = Position(
                x: next.x - 2 * sideLength,
                y: 4 * sideLength - 1
            )
            direction = .up

        case .down where ((2 * sideLength)..<(3 * sideLength)) ~= next.x && next.y == sideLength:
            next = Position(
                x: 2 * sideLength - 1,
                y: next.x - sideLength
            )
            direction = .left

        // 2nd row
        case .left where next.x == sideLength - 1 && (sideLength..<(2 * sideLength)) ~= next.y:
            next = Position(
                x: next.y - sideLength,
                y: 2 * sideLength
            )
            direction = .down

        case .right where next.x == 2 * sideLength && (sideLength..<(2 * sideLength)) ~= next.y:
            next = Position(
                x: next.y + sideLength,
                y: sideLength - 1
            )
            direction = .up

        // 3rd row
        case .left where next.x == -1 && (2 * sideLength)..<(3 * sideLength) ~= next.y:
            next = Position(
                x: sideLength,
                y: (next.y - 2 * sideLength).inverted(along: sideLength)
            )
            direction = .right

        case .up where 0..<sideLength ~= next.x && next.y == 2 * sideLength - 1:
            next = Position(
                x: sideLength,
                y: next.x + sideLength
            )
            direction = .right

        case .right where next.x == 2 * sideLength && (2 * sideLength)..<(3 * sideLength) ~= next.y:
            next = Position(
                x: 3 * sideLength - 1,
                y: (next.y - 2 * sideLength).inverted(along: sideLength)
            )
            direction = .left

        case .down where (sideLength..<(2 * sideLength)) ~= next.x && next.y == 3 * sideLength:
            next = Position(
                x: sideLength - 1,
                y: next.x + 2 * sideLength
            )
            direction = .left

        // 4th row
        case .left where next.x == -1 && (3 * sideLength)..<(4 * sideLength) ~= next.y:
            next = Position(
                x: next.y - 2 * sideLength,
                y: 0
            )
            direction = .down

        case .right where next.x == sideLength && (3 * sideLength)..<(4 * sideLength) ~= next.y:
            next = Position(
                x: next.y - 2 * sideLength,
                y: 3 * sideLength - 1
            )
            direction = .up

        case .down where 0..<sideLength ~= next.x && next.y == 4 * sideLength:
            next = Position(
                x: next.x + 2 * sideLength,
                y: 0
            )
            direction = .down

        default:
            fatalError("Unhandled direction \(direction) at \(next)")
        }

        assert(tiles.contains(next))
        return (next, direction)
    }

    private func wrapAround2D(next: Position) -> Position {
        var next = next
        switch direction {
        case .right:
            next = tiles.filter { $0.y == next.y }.min { $0.x < $1.x }!
        case .left:
            next = tiles.filter { $0.y == next.y }.max { $0.x < $1.x }!
        case .down:
            next = tiles.filter { $0.x == next.x }.min { $0.y < $1.y }!
        case .up:
            next = tiles.filter { $0.x == next.x }.max { $0.y < $1.y }!
        }

        if walls.contains(next) {
            return position
        } else {
            return next
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
                case "#", ".":
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
        filter { $0.y == 0 }.min { $0.x < $1.x }!
    }
}

extension Int {
    /// Inverts the integer along a given length
    ///
    /// Examples:
    /// - 0 inverted along 25 will return 24
    /// - 3 inverted along 25 will return 21
    /// - 12 inverted along 25 will return 12
    /// - 24 inverted along 25 will return 0
    public func inverted(along sideLength: Int) -> Int {
        assert((0..<sideLength).contains(self))

        let half = sideLength / 2
        return sideLength.isMultiple(of: 2)
            ? half + (half - self - 1)
            : half + (half - self)
    }
}
