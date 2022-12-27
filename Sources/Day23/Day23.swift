private enum Direction: CaseIterable, Comparable, Sequence {
    case north, south, west, east

    var next: Direction {
        switch self {
        case .north: return .south
        case .south: return .west
        case .west: return .east
        case .east: return .north
        }
    }

    func makeIterator() -> AnyIterator<Self> {
        var next = self
        return AnyIterator {
            defer { next = next.next }
            return next
        }
    }
}

private struct Position: Hashable {
    var x: Int
    var y: Int

    private var allNeighbors: Set<Position> {
        [
            Position(x: x - 1, y: y - 1),
            Position(x: x - 1, y: y),
            Position(x: x - 1, y: y + 1),
            Position(x: x + 1, y: y - 1),
            Position(x: x + 1, y: y),
            Position(x: x + 1, y: y + 1),
            Position(x: x, y: y + 1),
            Position(x: x, y: y - 1),
        ]
    }

    private func neighbors(to direction: Direction) -> Set<Position> {
        switch direction {
        case .north:
            return [
                Position(x: x - 1, y: y - 1),
                Position(x: x, y: y - 1),
                Position(x: x + 1, y: y - 1),
            ]
        case .south:
            return [
                Position(x: x - 1, y: y + 1),
                Position(x: x, y: y + 1),
                Position(x: x + 1, y: y + 1),
            ]
        case .west:
            return [
                Position(x: x - 1, y: y - 1),
                Position(x: x - 1, y: y),
                Position(x: x - 1, y: y + 1),
            ]
        case .east:
            return [
                Position(x: x + 1, y: y - 1),
                Position(x: x + 1, y: y),
                Position(x: x + 1, y: y + 1),
            ]
        }
    }

    func proposedMove(for positions: Set<Position>, lastProposedDirection: Direction) -> Position? {

        guard !allNeighbors.intersection(positions).isEmpty,
              let proposal = lastProposedDirection.lazy.prefix(4).compactMap({
                  neighbors(to: $0).intersection(positions).isEmpty ? $0 : nil
              }).first
        else { return nil }

        var position = self

        switch proposal {
        case .north:
            position.y -= 1
        case .south:
            position.y += 1
        case .west:
            position.x -= 1
        case .east:
            position.x += 1
        }

        return position
    }
}

public struct Plantation {
    private var elves: Set<Position>
    private var direction = Direction.north

    public init(_ input: String) {
        elves = Set(minimumCapacity: input.filter({ $0 == "#" }).count)
        for (y, line) in input.split(separator: "\n").enumerated() {
            for (x, c) in line.enumerated() {
                if c == "#" {
                    elves.insert(Position(x: x, y: y))
                }
            }
        }
    }

    public mutating func performElvesAlgorithm() {
        // Phase 1: Propose positions
        var proposedPositions: [Position: Position] = [:]
        var proposedPositionsCounts: [Position: Int] = [:]

        for elf in elves {
            guard let position = elf.proposedMove(for: elves, lastProposedDirection: direction)
            else { continue }
            proposedPositions[elf] = position
            proposedPositionsCounts[position, default: 0] += 1
        }

        // Phase 2: Move to proposed positions if possible
        elves = Set(elves.map { oldPosition in
            guard let proposedPosition = proposedPositions[oldPosition],
                  proposedPositionsCounts[proposedPosition] == 1
            else { return oldPosition }

            return proposedPosition
        })

        direction = direction.next
    }

    public var emptySpaces: Int {
        let box = elves.boundingBox
        let size = (box.max.x - box.min.x + 1) * (box.max.y - box.min.y + 1)
        return size - elves.count
    }

    public mutating func roundsUntilNoElfMoves() -> Int {
        var round = 0
        var before = elves

        repeat {
            before = elves
            performElvesAlgorithm()
            round += 1
        } while before != elves

        return round
    }

    public var description: String {
        var description = ""
        let box = elves.boundingBox
        for y in box.min.y...box.max.y {
            for x in box.min.x...box.max.x {
                if elves.contains(Position(x: x, y: y)) {
                    description.append("#")
                } else {
                    description.append(".")
                }
            }
            description.append("\n")
        }
        return description
    }
}

private extension Sequence where Element == Position {
    var boundingBox: (min: Position, max: Position) {
        let minX = map(\.x).min()!
        let minY = map(\.y).min()!
        let maxX = map(\.x).max()!
        let maxY = map(\.y).max()!

        return (
            min: Position(x: minX, y: minY),
            max: Position(x: maxX, y: maxY)
        )
    }
}
