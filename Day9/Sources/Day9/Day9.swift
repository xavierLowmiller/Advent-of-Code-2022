func numberOfPositionsTouchedByTail(_ input: String) -> Int {
    let motions = input.split(separator: "\n").map(Motion.init)
    var head = Position(x: 0, y: 0)
    var tail = Position(x: 0, y: 0)
    var positionsVisitedByTail: Set<Position> = [tail]

    for motion in motions {
        for _ in 0..<motion.amount {
            head.move(in: motion.direction)
            tail.move(relativeTo: head)
            assert(head.isTouching(tail))

            positionsVisitedByTail.insert(tail)
        }
    }

    return positionsVisitedByTail.count
}

func numberOfPositionsTouchedByLastKnot(_ input: String) -> Int {
    let motions = input.split(separator: "\n").map(Motion.init)
    var head = Position(x: 0, y: 0)
    var k1 = Position(x: 0, y: 0)
    var k2 = Position(x: 0, y: 0)
    var k3 = Position(x: 0, y: 0)
    var k4 = Position(x: 0, y: 0)
    var k5 = Position(x: 0, y: 0)
    var k6 = Position(x: 0, y: 0)
    var k7 = Position(x: 0, y: 0)
    var k8 = Position(x: 0, y: 0)
    var k9 = Position(x: 0, y: 0)
    var positionsVisitedByTail: Set<Position> = [k9]

    for motion in motions {
        for _ in 0..<motion.amount {
            head.move(in: motion.direction)

            k1.move(relativeTo: head); assert(k1.isTouching(head))
            k2.move(relativeTo: k1);   assert(k2.isTouching(k1))
            k3.move(relativeTo: k2);   assert(k3.isTouching(k2))
            k4.move(relativeTo: k3);   assert(k4.isTouching(k3))
            k5.move(relativeTo: k4);   assert(k5.isTouching(k4))
            k6.move(relativeTo: k5);   assert(k6.isTouching(k5))
            k7.move(relativeTo: k6);   assert(k7.isTouching(k6))
            k8.move(relativeTo: k7);   assert(k8.isTouching(k7))
            k9.move(relativeTo: k8);   assert(k9.isTouching(k8))

            positionsVisitedByTail.insert(k9)
        }
    }

    return positionsVisitedByTail.count
}

private enum Direction {
    case up, down, left, right
    init?(_ s: Substring) {
        switch s {
        case "U": self = .up
        case "D": self = .down
        case "L": self = .left
        case "R": self = .right
        default: return nil
        }
    }
}

private struct Motion {
    var direction: Direction
    var amount: Int

    init(_ input: Substring) {
        let m = input.wholeMatch(of: #/([UDLR]) (\d+)/#)!
        self.direction = Direction(m.1)!
        self.amount = Int(m.2)!
    }
}

private struct Position: Hashable {
    var x: Int
    var y: Int

    mutating func move(in direction: Direction) {
        switch direction {
        case .up: y -= 1
        case .down: y += 1
        case .left: x -= 1
        case .right: x += 1
        }
    }

    mutating func move(relativeTo position: Position) {
        switch (position.x, position.y) {
        case _ where position.isTouching(self):
            return

        // Direct cases
        case (x, y...):
            y += 1
        case (x, ...y):
            y -= 1
        case (x..., y):
            x += 1
        case (...x, y):
            x -= 1

        // Diagonal cases
        case (x..., y...):
            x += 1
            y += 1
        case (x..., ...y):
            x += 1
            y -= 1
        case (...x, y...):
            x -= 1
            y += 1
        case (...x, ...y):
            x -= 1
            y -= 1

        default:
            fatalError("Head \((position.x, position.y)), Tail \((x, y))")
        }
    }

    func isTouching(_ other: Position) -> Bool {
        abs(other.x - x) <= 1 && abs(other.y - y) <= 1
    }
}
