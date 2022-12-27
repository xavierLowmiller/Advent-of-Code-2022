import Algorithms

func sumOfPrioritiesOfItemInBothCompartments(input: String) -> Int {
    input.split(separator: "\n").map {
        let sharedItems = Set($0.prefix($0.count / 2))
            .intersection(Set($0.suffix($0.count / 2)))
        assert(sharedItems.count == 1)
        return Int(sharedItems.first!.value)
    }
    .reduce(0, +)
}

func sumOfPrioritiesOfElfBadges(input: String) -> Int {
    input.split(separator: "\n").chunks(ofCount: 3).map {
        Set($0[$0.startIndex])
            .intersection($0[$0.startIndex.advanced(by: 1)])
            .intersection($0[$0.startIndex.advanced(by: 2)])
            .first!
            .value
    }.reduce(0, +)
}

private extension Character {
    var value: Int {
        Int(isUppercase
            ? asciiValue! - Character("A").asciiValue! + 27
            : asciiValue! - Character("a").asciiValue! + 1)
    }
}
