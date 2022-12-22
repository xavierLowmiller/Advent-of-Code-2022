import Foundation

struct Labyrinth3D {
    struct Position: Hashable {
        var x: Int
        var y: Int
        var z: Int

        func next(in direction: inout Direction, sideLength: Int, walls: Set<Position>) -> Position {
            let min = 0
            let max = sideLength - 1
            switch (direction, x, y, z) {

            // Back tile
            case (.right, max, _, min):
                return Position(x: x, y: y, z: z + 1)
            case (.right, _, _, min):
                return Position(x: x + 1, y: y, z: z)
            case (.left, min, _, min):
                return Position(x: x, y: y, z: z + 1)
            case (.left, _, _, min):
                return Position(x: x - 1, y: y, z: z)
            case (.top, _, min, min):
                return Position(x: x, y: y, z: z + 1)
            case (.top, _, _, min):
                return Position(x: x, y: y - 1, z: z)
            case (.down, _, max, min):
                return Position(x: x, y: y, z: z + 1)
            case (.down, _, _, min):
                return Position(x: x, y: y + 1, z: z)

            // Right tile
            case (.right, max, _, max):
                return Position(x: x - 1, y: y, z: z)
            case (.right, max, _, _):
                return Position(x: x, y: y, z: z + 1)
            case (.left, max, _, min):
                return Position(x: x - 1, y: y, z: z)
            case (.left, max, _, _):
                return Position(x: x, y: y, z: z - 1)
            case (.top, max, min, _):
                return Position(x: x, y: y, z: z)
            case (.top, max, _, _):
                return Position(x: x, y: y - 1, z: z)
            }
        }
    }

    let sideLength: Int
    let walls: Set<Position>
    var position: Position = Position(x: 0, y: 0, z: 0)
    var direction: Direction = .right
    var instructions: [Instruction]

    init(_ input: String) {
        let map = input.split(separator: "\n\n")[0]
        sideLength = Int(Double(map.filter { !$0.isWhitespace }.count / 6).squareRoot())
        walls = Set(walls: map, sideLength: sideLength)
        var instructions = input.split(separator: "\n\n")[1]
        self.instructions = Array(&instructions)
    }

    mutating func walk() {
        while !instructions.isEmpty {
            switch instructions.removeFirst() {
            case .moveForward(let steps):
                for _ in 0..<steps {
                    position = position.next(in: &direction, sideLength: sideLength, walls: walls)
                    assert((0..<sideLength).contains(position.x))
                    assert((0..<sideLength).contains(position.y))
                    assert((0..<sideLength).contains(position.z))
                }
            case .turnLeft:
                direction.turnLeft()
            case .turnRight:
                direction.turnRight()
            }
        }
    }

    var score: Int {
        0
    }
}

extension Set where Element == Labyrinth3D.Position {
    init(walls: Substring, sideLength: Int) {


        self = []
    }
}
