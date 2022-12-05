enum Part {
    case part1
    case part2
}

struct Crane {
    private var stacks: [[Character]]
    private var instructions: [Instruction]
    private var part: Part

    init(_ input: String, part: Part) {
        stacks = input.split(separator: "\n\n").first.map(parseInitialState)!
        instructions = input.split(separator: "\n\n").last!.split(separator: "\n").map(Instruction.init)
        self.part = part
    }

    mutating func executeInstructions() {
        for instruction in instructions {
            let origin = instruction.origin
            let amount = instruction.amount
            let destination = instruction.destination
            let stacksMoved = stacks[origin].suffix(amount)
            stacks[origin].removeLast(amount)

            switch part {
            case .part1:
                stacks[destination].append(contentsOf: stacksMoved.reversed())
            case .part2:
                stacks[destination].append(contentsOf: stacksMoved)
            }
        }
    }

    var topCrates: String {
        String(stacks.compactMap(\.last))
    }
}


/// Parses stacks of crates
///
/// Input:
/// ```
///     [D]
/// [N] [C]
/// [Z] [M] [P]
///  1   2   3
///  ```
///
///  Output:
/// ```
/// [
///     [Z, N],
///     [M, C, D],
///     [P]
/// ]
///
private func parseInitialState(_ s: Substring) -> [[Character]] {
    var lines = s.split(separator: "\n")
    let amountOfStacks = Int(lines.removeLast().matches(of: #/(\d+)/#).last!.1)!
    var stacks: [[Character]] = Array(repeating: [], count: amountOfStacks)

    for line in lines.reversed() {
        var index = 0
        for m in line.matches(of: #/\[(\w)\]\s?|\s{4}/#) {
            if let c = m.1?.first {
                stacks[index].append(c)
            }
            index += 1
        }
    }

    return stacks
}

private struct Instruction {
    var amount: Int
    var origin: Int
    var destination: Int

    init(_ s: Substring) {
        let m = s.wholeMatch(of: #/move (\d+) from (\d+) to (\d+)/#)!
        self.amount = Int(m.1)!
        self.origin = Int(m.2)! - 1
        self.destination = Int(m.3)! - 1
    }
}
