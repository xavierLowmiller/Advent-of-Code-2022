func amountOfSandTheStructureCanHold(_ input: String, withFloor: Bool = false) -> Int {
    var points: Set<Position> = input
        .split(separator: "\n")
        .map(pointsFromRockFormation)
        .reduce(into: [], { $0.formUnion($1) })

    let lowestY = points.map(\.y).max()!

    if withFloor {
        // Add "floor"
        let minX = points.map(\.x).min()! - 10000
        let maxX = points.map(\.x).max()! + 10000
        points.formUnion(Position.positions(
            from: Position(x: minX, y: lowestY + 2),
            to: Position(x: maxX, y: lowestY + 2)
        ))
    }

    let countWithoutSand = points.count

    while points.addSand(withFloor ? lowestY + 2 : lowestY) {}

    return points.count - countWithoutSand
}

private func pointsFromRockFormation(_ input: Substring) -> Set<Position> {
    let edges = input.split(separator: " -> ").map(Position.init)
    var points: Set<Position> = []
    for (p1, p2) in zip(edges, edges.dropFirst()) {
        points.formUnion(Position.positions(from: p1, to: p2))
    }

    return points
}

private extension Set<Position> {
    mutating func addSand(_ lowestY: Int) -> Bool {
        var sand = Position(x: 500, y: 0)

        while sand.y <= lowestY, !self.contains(sand) {
            let next1 = Position(x: sand.x, y: sand.y + 1)
            let next2 = Position(x: sand.x - 1, y: sand.y + 1)
            let next3 = Position(x: sand.x + 1, y: sand.y + 1)

            if !self.contains(next1) {
                sand = next1
            } else if !self.contains(next2) {
                sand = next2
            } else if !self.contains(next3) {
                sand = next3
            } else {
                self.insert(sand)
                return true
            }
        }

        return false
    }
}

private struct Position: Hashable {
    let x: Int
    let y: Int
}

extension Position {
    init(_ input: Substring) {
        x = Int(input.split(separator: ",")[0])!
        y = Int(input.split(separator: ",")[1])!
    }

    static func positions(from p1: Position, to p2: Position) -> Set<Position> {
        if p1.x == p2.x {
            let y1 = min(p1.y, p2.y)
            let y2 = max(p1.y, p2.y)
            return Set((y1...y2).map { Position(x: p1.x, y: $0) })
        }
        if p1.y == p2.y {
            let x1 = min(p1.x, p2.x)
            let x2 = max(p1.x, p2.x)
            return Set((x1...x2).map { Position(x: $0, y: p1.y) })
        }
        fatalError("Not in a straight line")
    }
}
