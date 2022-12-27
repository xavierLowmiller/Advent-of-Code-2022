public func numberOfPositionsThatCantContainABeacon(atLine line: Int, input: String) -> Int {
    let positions = input.split(separator: "\n").map(\.sensorAndBeacon)

    let overlaps = positions.compactMap { $0.overlap(withLine: line) }
    return overlaps.reduced.map(\.count).reduce(0, +)
}

public func onlyPossiblePosition(inRange maxRange: Int, input: String) -> Position {
    let positions = input.split(separator: "\n").map(\.sensorAndBeacon)

    var xs: [Int] = []
    for possibleX in 0...maxRange {
        let overlaps = positions.compactMap { $0.overlap(withColumn: possibleX) }
        if overlaps.reduced.count > 1 {
            xs.append(possibleX)
        }
    }

    var ys: [Int] = []
    for possibleY in 0...maxRange {
        let overlaps = positions.compactMap { $0.overlap(withLine: possibleY) }
        if overlaps.reduced.count > 1 {
            ys.append(possibleY)
        }
    }

    for x in xs {
        for y in ys {
            let p = Position(x: x, y: y)
            if positions.allSatisfy({ !$0.contains(p: p) }) {
                return p
            }
        }
    }

    fatalError("no suitable position found")
}

extension ClosedRange {
    func joined(with other: Self) -> Self {
        assert(self.overlaps(other))

        let l = Swift.min(lowerBound, other.lowerBound)
        let u = Swift.max(upperBound, other.upperBound).self

        return l...u
    }
}

extension ClosedRange where Bound == Int {
    var count: Int {
        upperBound - lowerBound
    }
}

extension Array where Element == ClosedRange<Int> {
    var reduced: Self {
        let sorted = sorted { $0.lowerBound < $1.lowerBound }
        for (i1, i2) in zip(sorted.indices, sorted.dropFirst().indices) {
            let r1 = sorted[i1]
            let r2 = sorted.dropFirst()[i2]
            if r1.overlaps(r2) {
                print("Before: ", count)
                let a = (sorted[safe: ..<i1] + [r1.joined(with: r2)] + sorted[safe: (i2 + 2)...]).reduced
                print("After: ", a.count)
                return a
            }
        }

        return self
    }

    subscript(safe range: PartialRangeUpTo<Int>) -> ArraySlice<ClosedRange<Int>> {
        get {
            guard range.upperBound > startIndex else { return [] }
            return prefix(range.upperBound - startIndex)
        }
    }

    subscript(safe range: PartialRangeFrom<Int>) -> ArraySlice<ClosedRange<Int>> {
        get {
            guard range.lowerBound < endIndex else { return [] }
            return suffix(endIndex - range.lowerBound)
        }
    }
}

struct SensorAndBeacon: Hashable {
    let sensor: Position
    let beacon: Position

    var radius: Int {
        sensor.manhattanDistance(to: beacon)
    }

    func contains(p: Position) -> Bool {
        sensor.manhattanDistance(to: p) <= radius
    }

    func overlap(withLine line: Int) -> ClosedRange<Int>? {
        guard ((sensor.y - radius)...(sensor.y + radius)).contains(line) else { return nil }

        let r = radius - abs(line - sensor.y)

        return (sensor.x - r)...(sensor.x + r)
    }

    func overlap(withColumn column: Int) -> ClosedRange<Int>? {
        guard ((sensor.x - radius)...(sensor.x + radius)).contains(column) else { return nil }

        let r = radius - abs(column - sensor.x)

        return (sensor.y - r)...(sensor.y + r)
    }
}

public struct Position: Hashable {
    public let x: Int
    public let y: Int

    public var tuningFrequency: Int {
        x * 4000000 + y
    }

    func manhattanDistance(to other: Position) -> Int {
        abs(other.x - x) + abs(other.y - y)
    }

    func areaCovered(closestBeacon: Position) -> Set<Position> {
        let radius = manhattanDistance(to: closestBeacon)
        var area: Set<Position> = []
        for x in (x - radius)...(x + radius) {
            for y in (y - radius)...(y + radius) {
                let p = Position(x: x, y: y)
                if manhattanDistance(to: p) <= radius {
                    area.insert(p)
                }
            }
        }
        return area
    }
}

private extension Substring {
    var sensorAndBeacon: SensorAndBeacon {
        let m = wholeMatch(of: #/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/#)!
        return SensorAndBeacon(
            sensor: Position(x: Int(m.1)!, y: Int(m.2)!),
            beacon: Position(x: Int(m.3)!, y: Int(m.4)!)
        )
    }
}
