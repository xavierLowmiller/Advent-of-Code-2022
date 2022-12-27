import AOCAlgorithms

private typealias Height = Int

private struct Position: Hashable {
    let x: Int
    let y: Int

    func distance(to other: Position) -> Int {
        abs(x - other.x) + abs(y - other.y)
    }
}

private struct HeightMap {
    let start: Position
    let target: Position
    let map: [Position: Height]
    let lowPoints: Set<Position>

    func neighbors(of position: Position) -> Set<Position> {
        let neighbors: Set<Position> = [
            Position(x: position.x + 1, y: position.y),
            Position(x: position.x - 1, y: position.y),
            Position(x: position.x, y: position.y + 1),
            Position(x: position.x, y: position.y - 1)
        ]
        return neighbors.filter { (map[$0] ?? 10000) - map[position]! <= 1 }
    }
}

public func leastAmountOfStepsPart1(_ input: String) -> Int {
    let heightField = parseHeightField(input)

    return aStar(
        start: heightField.start,
        goal: heightField.target,
        heuristic: { heightField.target.distance(to: $0) },
        neighbors: { heightField.neighbors(of: $0) }
    )!.count - 1
}

public func leastAmountOfStepsPart2(_ input: String) -> Int {
    let heightField = parseHeightField(input)

    return heightField.lowPoints.compactMap {
        guard let path = aStar(
            start: $0,
            goal: heightField.target,
            heuristic: { heightField.target.distance(to: $0) },
            neighbors: { heightField.neighbors(of: $0) }
        ) else { return nil }

        return path.count - 1
    }.min()!
}

private func parseHeightField(_ input: String) -> HeightMap {
    var start: Position?
    var target: Position?
    var lowPoints: Set<Position> = []
    var map: [Position: Height] = [:]

    for (y, line) in input.split(separator: "\n").enumerated() {
        for (x, c) in line.enumerated() {
            let position = Position(x: x, y: y)
            map[position] = c.height
            if c == "S" { start = position; lowPoints.insert(position) }
            if c == "E" { target = position }
            if c == "a" { lowPoints.insert(position) }
        }
    }

    return HeightMap(
        start: start!,
        target: target!,
        map: map,
        lowPoints: lowPoints
    )
}

private extension Character {
    var height: Height {
        switch self {
        case "S":
            return Character("a").height
        case "E":
            return Character("z").height
        case let c:
            return Int(c.asciiValue! - Character("a").asciiValue!)
        }
    }
}
