public func surfaceOfLavaDroplet(_ input: String) -> Int {
    let lavaDroplet = Set(input.split(separator: "\n").map(Position.init))
    return lavaDroplet.surfaceArea
}

public func surfaceOfLavaDropletWithoutContainedAir(_ input: String) -> Int {
    let lavaDroplet = Set(input.split(separator: "\n").map(Position.init))
    return lavaDroplet.surfaceAreaWithoutContainedAir
}

struct Position: Hashable {
    let x: Int
    let y: Int
    let z: Int
}

extension Position {
    init(_ input: Substring) {
        let s = input.split(separator: ",")
        x = Int(s[0])!
        y = Int(s[1])!
        z = Int(s[2])!
    }

    var neighbors: Set<Position> {
        [
            Position(x: x + 1, y: y, z: z),
            Position(x: x - 1, y: y, z: z),
            Position(x: x, y: y + 1, z: z),
            Position(x: x, y: y - 1, z: z),
            Position(x: x, y: y, z: z + 1),
            Position(x: x, y: y, z: z - 1),
        ]
    }
}

extension Set where Element == Position {
    var surfaceArea: Int {
        var area = 0

        for element in self {
            let neighbors = element.neighbors.intersection(self)
            area += 6 - neighbors.count
        }

        return area
    }

    var surfaceAreaWithoutContainedAir: Int {

        let surfaceArea = self.surfaceArea

        let fullyCoveredPositions = self.fullyCoveredPositions

        return surfaceArea - fullyCoveredPositions.surfaceArea
    }

    var fullyCoveredPositions: Set<Position> {
        var doesNotNeedToBeChecked = self

        var coveredPositions: Set<Position> = [] {
            didSet { doesNotNeedToBeChecked.formUnion(coveredPositions) }
        }

        var outsideAir: Set<Position> = [] {
            didSet { doesNotNeedToBeChecked.formUnion(outsideAir) }
        }

        let xRange = map(\.x).min()!...map(\.x).max()!
        let yRange = map(\.y).min()!...map(\.y).max()!
        let zRange = map(\.z).min()!...map(\.z).max()!

        for x in xRange {
            for y in yRange {
                for z in zRange {
                    let p = Position(x: x, y: y, z: z)
                    guard !doesNotNeedToBeChecked.contains(p) else { continue }

                    var currentHoleSet: Set<Position> = [p]
                    var neighborsToCheck = p.neighbors.subtracting(self)

                    while let p = neighborsToCheck.first {
                        // Check if air pocket is actually outside
                        guard xRange.contains(p.x), yRange.contains(p.y), zRange.contains(p.z) else {
                            outsideAir.formUnion(currentHoleSet)
                            currentHoleSet = []
                            break
                        }

                        currentHoleSet.insert(p)

                        let alreadyCheckedOrWall = currentHoleSet.union(self)
                        let neighbors = p.neighbors.subtracting(alreadyCheckedOrWall)
                        neighborsToCheck.formUnion(neighbors)
                        neighborsToCheck.remove(p)
                    }

                    coveredPositions.formUnion(currentHoleSet)
                }
            }
        }

        return coveredPositions
    }
}
