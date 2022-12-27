private typealias ItemValue = UInt
private typealias MonkeyIndex = Array<Monkey>.Index

public enum Mode {
    case part1
    case part2
}

public func playMonkeyGame(input: String, rounds: Int, mode: Mode) -> Int {
    var monkeys = input.split(separator: "\n\n").map(Monkey.init)
    let commonTestNumber = monkeys.reduce(1, { $0 * $1.testValue })

    for _ in 0..<rounds {
        var index = monkeys.startIndex

        while index < monkeys.endIndex {
            var monkey = monkeys[index]
            while !monkey.items.isEmpty {
                monkey.itemsHeld += 1

                var item = monkey.items.removeFirst()
                item = monkey.operation(item)
                if mode == .part1 {
                    item /= 3
                } else {
                    item %= commonTestNumber
                }
                let target = item.isMultiple(of: monkey.testValue)
                    ? monkey.monkeyIndices.0
                    : monkey.monkeyIndices.1
                monkeys[target].items.append(item)
            }
            monkeys[index] = monkey

            index = monkeys.index(after: index)
        }
    }

    let topMonkeys = monkeys.sorted { $0.itemsHeld > $1.itemsHeld }
    return topMonkeys[0].itemsHeld * topMonkeys[1].itemsHeld
}

private struct Monkey {
    var items: [ItemValue]
    var itemsHeld = 0
    let operation: (ItemValue) -> ItemValue
    let testValue: ItemValue
    let monkeyIndices: (MonkeyIndex, MonkeyIndex)

    init(_ input: Substring) {
        let m = input.firstMatch(of: #/
        Monkey\ \d:\
        \ \ Starting\ items:\ (.*)\
        \ \ Operation:\ (.*)\
        \ \ Test:\ divisible\ by\ (\d+)\
        \ \ \ \ If\ true:\ throw\ to\ monkey\ (\d)\
        \ \ \ \ If\ false:\ throw\ to\ monkey\ (\d)
        /#)!

        items = m.1.split(separator: ", ").compactMap { ItemValue($0) }
        operation = parseOperation(for: m.2)
        testValue = ItemValue(m.3)!
        monkeyIndices = (MonkeyIndex(m.4)!, MonkeyIndex(m.5)!)
    }
}

private func parseOperation(for input: Substring) -> (ItemValue) -> ItemValue {
    let m = input.wholeMatch(of: #/new = old (\+|\*) (old|\d+)/#)!
    switch (m.1, m.2) {
    case ("*", "old"):
        return { $0 * $0 }
    case ("+", "old"):
        return { $0 + $0 }
    case ("*", let arg):
        return { $0 * ItemValue(arg)! }
    case ("+", let arg):
        return { $0 + ItemValue(arg)! }
    default:
        fatalError("Unexpected pattern \(input)")
    }
}
