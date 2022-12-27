public func elfWithMostCalories(_ input: String) -> Int {
    elves(input).max()!
}

public func elvesWithTopThreeCalories(_ input: String) -> Int {
    elves(input).sorted(by: >).prefix(3).reduce(0, +)
}

private func elves(_ input: String) -> [Int] {
    input
        // Individual elves are separated by double spaces
        .split(separator: "\n\n")
        // The calories each elf is carrying are integers separated by spaces
        .map { $0.split(separator: "\n").compactMap { Int($0) }.reduce(0, +) }
}
