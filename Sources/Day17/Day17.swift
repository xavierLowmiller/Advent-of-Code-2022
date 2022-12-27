typealias Shape = Set<Position>

public func simulateFallingRocks(_ input: String, amount: Int) -> Int {
    var maxY = 0
    var existingTiles: Shape = [
        Position(x: 1, y: 0),
        Position(x: 2, y: 0),
        Position(x: 3, y: 0),
        Position(x: 4, y: 0),
        Position(x: 5, y: 0),
        Position(x: 6, y: 0),
        Position(x: 7, y: 0),
    ]
    let input: [Character] = Array(input)
    var index = 0

    var cache: [CacheElement: (Int, Int)] = [:]

    var iterationToSkipTo: Int!

    for number in 1...amount {
        let height = existingTiles.maxYIndex
        var nextElement = Shape(at: height, number: number)
        nextElement.move(
            accordingTo: input,
            index: &index,
            existingTiles: existingTiles
        )
        maxY += max(nextElement.maxYIndex - height, 0)
        existingTiles.formUnion(nextElement)
        existingTiles.prune()

        let key = CacheElement(shape: nextElement, index: index % input.count)
        if let (cycleStart, cycleStartHeight) = cache[key] {
            // Cycle detected!
            let cycleLength = number - cycleStart
            let heightGainedInCycle = maxY - cycleStartHeight
            let cyclesToSkip = (amount - cycleStart) / cycleLength
            maxY = cycleStartHeight + cyclesToSkip * heightGainedInCycle
            iterationToSkipTo = cycleLength * cyclesToSkip + cycleStart + 1
            break
        } else {
            cache[key] = (number, maxY)
        }
    }

    for number in iterationToSkipTo...amount {
        let height = existingTiles.maxYIndex
        var nextElement = Shape(at: height, number: number)
        nextElement.move(
            accordingTo: input,
            index: &index,
            existingTiles: existingTiles
        )
        maxY += max(nextElement.maxYIndex - height, 0)
        existingTiles.formUnion(nextElement)
        existingTiles.prune()
    }

    return maxY
}

private struct CacheElement: Hashable {
    let shape: Shape
    let index: Int
}

struct Position: Hashable {
    var x: Int
    var y: Int
}

extension Shape {
    init(at height: Int, number: Int) {
        let spawnHeight = height + 4
        switch (number - 1) % 5 {
        case 0: // -
            self = [
                Position(x: 3, y: spawnHeight),
                Position(x: 4, y: spawnHeight),
                Position(x: 5, y: spawnHeight),
                Position(x: 6, y: spawnHeight),
            ]
        case 1: // +
            self = [
                Position(x: 4, y: spawnHeight),
                Position(x: 3, y: spawnHeight + 1),
                Position(x: 4, y: spawnHeight + 1),
                Position(x: 5, y: spawnHeight + 1),
                Position(x: 4, y: spawnHeight + 2),
            ]
        case 2: // reverse L
            self = [
                Position(x: 3, y: spawnHeight),
                Position(x: 4, y: spawnHeight),
                Position(x: 5, y: spawnHeight),
                Position(x: 5, y: spawnHeight + 1),
                Position(x: 5, y: spawnHeight + 2),
            ]
        case 3: // I
            self = [
                Position(x: 3, y: spawnHeight),
                Position(x: 3, y: spawnHeight + 1),
                Position(x: 3, y: spawnHeight + 2),
                Position(x: 3, y: spawnHeight + 3),
            ]
        case 4: // O
            self = [
                Position(x: 3, y: spawnHeight),
                Position(x: 4, y: spawnHeight),
                Position(x: 3, y: spawnHeight + 1),
                Position(x: 4, y: spawnHeight + 1),
            ]
        default:
            fatalError()
        }
    }

    var minXIndex: Int {
        map(\.x).min()!
    }

    var maxXIndex: Int {
        map(\.x).max()!
    }

    var minYIndex: Int {
        map(\.y).min()!
    }

    var maxYIndex: Int {
        map(\.y).max()!
    }

    mutating func move(
        accordingTo instructions: [Character],
        index: inout Int,
        existingTiles: Shape
    ) {
        while true {
            defer { index += 1 }

            // Move left or right
            do {
                let nextStep: Shape

                switch instructions[index % instructions.count] {
                case "<":
                    if minXIndex == 1 {
                        nextStep = self
                    } else {
                        nextStep = Set(self.map { Position(x: $0.x - 1, y: $0.y) })
                    }
                case ">":
                    if maxXIndex == 7 {
                        nextStep = self
                    } else {
                        nextStep = Set(self.map { Position(x: $0.x + 1, y: $0.y) })
                    }
                default:
                    fatalError("invalid input \(instructions[index % instructions.count])")
                }

                if nextStep.intersection(existingTiles).isEmpty {
                    // No collision, execute left or right
                    self = nextStep
                } else {
                    // Collision, don't move left or right, but try downwards
                }
            }

            // Move down
            do {
                let nextStep = Set(self.map { Position(x: $0.x, y: $0.y - 1) })
                if nextStep.intersection(existingTiles).isEmpty {
                    // No collision, continue
                    self = nextStep
                } else {
                    // Collision, don't move down
                    break
                }
            }
        }
    }

    mutating func prune() {
        let minY = maxYIndex - 100
        let actualMinY = minYIndex
        let delta = Swift.max(minY - actualMinY, 0)

        self = Set(filter { $0.y >= minY }.map { Position(x: $0.x, y: $0.y - delta) })

        assert(maxYIndex <= 100)
        assert(minYIndex >= 0)
    }
}
