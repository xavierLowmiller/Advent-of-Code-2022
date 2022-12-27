struct CPU {

    var x = 1
    var cycle = 0
    var instructions: [Instruction]
    var pendingInstruction: Instruction?
    var signals: [Int] = []

    var crt = ""

    init(_ input: String) {
        instructions = input.split(separator: "\n").map(Instruction.init)
    }

    mutating func runCycles() {
        while !instructions.isEmpty {
            let hIndex = (cycle % 40)

            cycle += 1

            if [20, 60, 100, 140, 180, 220].contains(cycle) {
                signals.append(cycle * x)
            }

            if x - 1 == hIndex || x == hIndex || x + 1 == hIndex {
                crt.append("#")
            } else {
                crt.append(".")
            }
            if cycle.isMultiple(of: 40) {
                crt.append("\n")
            }

            if case let .addx(v) = pendingInstruction {
                x += v
                pendingInstruction = nil
            } else {
                let instruction = instructions.removeFirst()
                switch instruction {
                case .noop:
                    break
                case .addx:
                    pendingInstruction = instruction
                }
            }
        }
        crt.removeLast()
    }

    var signalStrength: Int {
        signals.reduce(0, +)
    }
}

enum Instruction {
    case addx(Int)
    case noop

    init(_ s: Substring) {
        if s.wholeMatch(of: #/noop/#) != nil {
            self = .noop
        } else if let m = s.wholeMatch(of: #/addx (-?\d+)/#) {
            self = .addx(Int(m.1)!)
        } else {
            fatalError("Unknown instruction \(s)")
        }
    }
}
