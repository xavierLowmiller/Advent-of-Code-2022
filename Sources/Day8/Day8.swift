private struct Coord: Hashable {
    let x: Int
    let y: Int
}

public struct TreeGrid {
    typealias Height = Int
    private var trees: [Coord: Height] = [:]
    private let maxX: Int
    private let maxY: Int

    public init(_ input: String) {
        var x = 0
        var y = 0
        for line in input.split(separator: "\n") {
            x = 0
            for c in line {
                trees[Coord(x: x, y: y)] = Height(String(c))!
                x += 1
            }
            y += 1
        }
        maxX = x - 1
        maxY = y - 1
    }

    public var amountOfVisibleTrees: Int {
        var visibleTrees = 0
        for x in 0...maxX {
            for y in 0...maxY {
                guard let height = trees[Coord(x: x, y: y)] else { fatalError("out of range") }

                // On the edge, all trees are visible
                guard x > 0, x < maxX, y > 0, y < maxY else { visibleTrees += 1; continue }

                let leftTrees =            (0..<x).compactMap({ trees[Coord(x: $0, y: y)] })
                let rightTrees =  ((x + 1)...maxX).compactMap({ trees[Coord(x: $0, y: y)] })
                let topTrees =             (0..<y).compactMap({ trees[Coord(x: x, y: $0)] })
                let bottomTrees = ((y + 1)...maxY).compactMap({ trees[Coord(x: x, y: $0)] })

                if [leftTrees, rightTrees, topTrees, bottomTrees]
                    .contains(where: { $0.allSatisfy { $0 < height } }) {
                    visibleTrees += 1
                }
            }
        }

        return visibleTrees
    }

    public var highestScenicScore: Int {
        var highestScore = 0

        for x in 1..<maxX {
            for y in 1..<maxY {
                guard let height = trees[Coord(x: x, y: y)] else { fatalError("out of range") }

                let leftTrees = (0..<x).reversed().compactMap { trees[Coord(x: $0, y: y)] }
                let rightTrees =  ((x + 1)...maxX).compactMap { trees[Coord(x: $0, y: y)] }
                let topTrees =  (0..<y).reversed().compactMap { trees[Coord(x: x, y: $0)] }
                let bottomTrees = ((y + 1)...maxY).compactMap { trees[Coord(x: x, y: $0)] }

                highestScore = max(
                    highestScore,
                    [leftTrees, rightTrees, topTrees, bottomTrees]
                        .map { $0.viewDistance(for: height) }
                        .reduce(1, *)
                )
            }
        }

        return highestScore
    }
}

private extension Array where Element == TreeGrid.Height {
    func viewDistance(for height: TreeGrid.Height) -> Int {
        (firstIndex(where: { $0 >= height }) ?? count - 1) + 1
    }
}
