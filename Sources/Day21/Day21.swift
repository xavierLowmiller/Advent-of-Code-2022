private typealias Operation = ([Substring: Int]) -> Int?

func solveRiddle1(_ input: String) -> Int {
    let lines = input.split(separator: "\n")
    var operations: [Substring: Operation] = Dictionary(minimumCapacity: lines.count)
    for line in lines {
        let (monkey, op) = parseOperation(line)
        operations[monkey] = op
    }

    var solutions: [Substring: Int] = Dictionary(minimumCapacity: lines.count)
    while solutions["root"] == nil {
        let knownSolutions = solutions.keys
        for (monkey, operation) in operations where !knownSolutions.contains(monkey) {
            if let solution = operation(solutions) {
                solutions[monkey] = solution
            }
        }
    }

    return solutions["root"]!
}

func solveRiddle2(_ input: String) -> Int {
    let lines = input.split(separator: "\n").filter { !$0.hasPrefix("humn") }

    var operations: [Substring: [Operation]] = Dictionary(minimumCapacity: lines.count)
    for line in lines {
        for (name, operation) in parseOperations(for: line) {
            operations[name, default: []].append(operation)
        }
    }

    var solutions: [Substring: Int] = Dictionary(minimumCapacity: lines.count)

    while solutions["humn"] == nil {
        let knownSolutions = solutions.keys
        for (monkey, operations) in operations where !knownSolutions.contains(monkey) {
            for operation in operations {
                if let solution = operation(solutions) {
                    solutions[monkey] = solution
                }
            }
        }
    }

    return solutions["humn"]!
}

private func parseOperation(_ input: Substring) -> (monkey: Substring, op: Operation) {
    let literal =   #/(\w+): (\d+)/#
    let plus =      #/(\w+): (\w+) \+ (\w+)/#
    let minus =     #/(\w+): (\w+) \- (\w+)/#
    let multiply =  #/(\w+): (\w+) \* (\w+)/#
    let divide =    #/(\w+): (\w+) \/ (\w+)/#

    if let m = input.wholeMatch(of: literal) {
        return (m.1, { _ in Int(m.2)! })
    }

    if let m = input.wholeMatch(of: plus) {
        return (m.1, { dict in
            guard let m1 = dict[m.2], let m2 = dict[m.3] else { return nil }
            return m1 + m2
        })
    }

    if let m = input.wholeMatch(of: minus) {
        return (m.1, { dict in
            guard let m1 = dict[m.2], let m2 = dict[m.3] else { return nil }
            return m1 - m2
        })
    }

    if let m = input.wholeMatch(of: multiply) {
        return (m.1, { dict in
            guard let m1 = dict[m.2], let m2 = dict[m.3] else { return nil }
            return m1 * m2
        })
    }

    if let m = input.wholeMatch(of: divide) {
        return (m.1, { dict in
            guard let m1 = dict[m.2], let m2 = dict[m.3] else { return nil }
            return m1 / m2
        })
    }

    fatalError("Unrecognized pattern: \(input)")
}

private func parseOperations(for line: Substring) -> [(name: Substring, operation: Operation)] {
    let literal =   #/(\w+): (\d+)/#
    let root =      #/root: (\w+) . (\w+)/#
    let plus =      #/(\w+): (\w+) \+ (\w+)/#
    let minus =     #/(\w+): (\w+) \- (\w+)/#
    let multiply =  #/(\w+): (\w+) \* (\w+)/#
    let divide =    #/(\w+): (\w+) \/ (\w+)/#

    var operations: [(Substring, Operation)] = []

    if let m = line.wholeMatch(of: literal) {
        operations = [(m.1, { _ in Int(m.2) })]
    } else if let m = line.wholeMatch(of: root) {
        operations = [
            (m.1, { $0[m.2] }),
            (m.2, { $0[m.1] }),
        ]
    } else if let m = line.wholeMatch(of: plus) {
        operations = [
            (m.1, { // x = m1 + m2
                guard let m1 = $0[m.2], let m2 = $0[m.3] else { return nil }
                return m1 + m2
            }),
            (m.2, { // m1 = x + m2
                guard let m1 = $0[m.1], let m2 = $0[m.3] else { return nil }
                return m1 - m2
            }),
            (m.3, { // m1 = m2 + x
                guard let m1 = $0[m.1], let m2 = $0[m.2] else { return nil }
                return m1 - m2
            }),
        ]
    } else if let m = line.wholeMatch(of: minus) {
        operations = [
            (m.1, { // x = m1 - m2
                guard let m1 = $0[m.2], let m2 = $0[m.3] else { return nil }
                return m1 - m2
            }),
            (m.2, { // m1 = x - m2
                guard let m1 = $0[m.1], let m2 = $0[m.3] else { return nil }
                return m1 + m2
            }),
            (m.3, { // m1 = m2 - x
                guard let m1 = $0[m.1], let m2 = $0[m.2] else { return nil }
                return m2 - m1
            }),
        ]
    } else if let m = line.wholeMatch(of: multiply) {
        operations = [
            (m.1, { // x = m1 * m2
                guard let m1 = $0[m.2], let m2 = $0[m.3] else { return nil }
                return m1 * m2
            }),
            (m.2, { // m1 = x * m2
                guard let m1 = $0[m.1], let m2 = $0[m.3] else { return nil }
                return m1 / m2
            }),
            (m.3, { // m1 = m2 * x
                guard let m1 = $0[m.1], let m2 = $0[m.2] else { return nil }
                return m1 / m2
            }),
        ]
    } else if let m = line.wholeMatch(of: divide) {
        operations = [
            (m.1, { // x = m1 / m2
                guard let m1 = $0[m.2], let m2 = $0[m.3] else { return nil }
                return m1 / m2
            }),
            (m.2, { // m1 = x / m2
                guard let m1 = $0[m.1], let m2 = $0[m.3] else { return nil }
                return m1 * m2
            }),
            (m.3, { // m1 = m2 / x
                guard let m1 = $0[m.1], let m2 = $0[m.2] else { return nil }
                return m2 / m1
            }),
        ]
    }

    return operations
}
