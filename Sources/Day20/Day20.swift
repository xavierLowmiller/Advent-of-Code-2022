import AOCAlgorithms
import Foundation

private struct N: Identifiable, Equatable {
    let id = UUID()
    var value: Int

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public struct Decryption {
    private var array: Array<N>
    private let isPart2: Bool

    public init(_ input: String, isPart2: Bool) {
        let factor = isPart2 ? 811589153 : 1
        array = input
            .split(separator: "\n")
            .map { N(value: Int($0)! * factor) }
        self.isPart2 = isPart2
    }


    public mutating func mix() {
        let order = array
        for _ in 0..<(isPart2 ? 10 : 1) {
            for n in order {
                array.mix(n: n)
            }
        }
    }

    public var score: Int {
        let indicesToCheck = [1000, 2000, 3000]
        let zeroIndex = array.firstIndex(where: { $0.value == 0 })!

        var score = 0
        for index in indicesToCheck {
            score += array[(zeroIndex + index) % array.count].value
        }
        return score
    }
}

private extension Array where Element == N {
    mutating func mix(n: Element) {
        guard let index = firstIndex(of: n) else { return }

        var target = index + n.value

        if !indices.contains(target) {
            target = target %% (count - 1)
        }

        remove(at: index)
        insert(n, at: target)
    }
}
