
enum Direction: Int {
    case right = 0
    case down = 1
    case left = 2
    case top = 3

    mutating func turnRight() {
        self = Direction(rawValue: (rawValue + 1) % 4)!
    }

    mutating func turnLeft() {
        self = Direction(rawValue: (rawValue + 3) % 4)!
    }
}

enum Instruction {
    case moveForward(_ steps: Int)
    case turnLeft
    case turnRight
}

extension Array where Element == Instruction {
    init(_ s: inout Substring) {
        var instructions: [Instruction] = []

        while !s.isEmpty {
            let number = s.prefix(while: \.isWholeNumber)
            if number.isEmpty {
                switch s.removeFirst() {
                case "L":
                    instructions.append(.turnLeft)
                case "R":
                    instructions.append(.turnRight)
                default:
                    fatalError("Unrecognized Character")
                }
            } else {
                instructions.append(.moveForward(Int(number)!))
                s.removeFirst(number.count)
            }
        }

        self = instructions
    }
}
