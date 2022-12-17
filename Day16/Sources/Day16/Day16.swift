import IdentifiedCollections

public struct ValveNetwork: Hashable {
    var remainingTime = 30
    var flowRate = 0
    var currentNode: Node.ID
    var elephantNode: Node.ID?

    var openNodes: Set<Node.ID>
    let network: IdentifiedArrayOf<Node>

    public var maxSteamReleased: Int {
        if let max = Self.cache[self] {
            return max
        } else {
            let steamReleased = flowRate + (neighbors.map(\.maxSteamReleased).max() ?? 0)
            Self.cache[self] = steamReleased

            return steamReleased
        }
    }

    private static var cache: [ValveNetwork: Int] = [:]

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.remainingTime == rhs.remainingTime &&
        lhs.flowRate == rhs.flowRate &&
        lhs.currentNode == rhs.currentNode &&
        lhs.elephantNode == rhs.elephantNode
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(remainingTime)
        hasher.combine(flowRate)
        hasher.combine(currentNode)
        hasher.combine(elephantNode)
    }
}

struct Node: Identifiable, Hashable {
    var id: String
    var flowRate: Int
    var neighbors: Set<Node.ID>

    init(_ input: Substring) {
        let m = input.wholeMatch(of: #/Valve (\w{2}) has flow rate=(\d+); tunnels? leads? to valves? (.*)/#)!
        id = ID(m.1)
        flowRate = Int(m.2)!
        neighbors = Set(m.3.split(separator: ", ").map(ID.init))
    }
}

extension ValveNetwork {
    var neighbors: Set<ValveNetwork> {
        guard remainingTime > 1 else { return [] }

        var neighbors: Set<ValveNetwork> = []

        // Option 1: Open valve (if it can be opened)
        if !openNodes.contains(currentNode) {
            var neighbor = self
            neighbor.flowRate += network[id: currentNode]!.flowRate
            neighbor.openNodes.insert(currentNode)
            neighbor.remainingTime -= 1
            neighbors.insert(neighbor)
        }

        // Option 2: Move to one of the neighbors
        for index in network[id: currentNode]!.neighbors {
            var neighbor = self
            neighbor.currentNode = index
            neighbor.remainingTime -= 1
            neighbors.insert(neighbor)
        }

        if let elephantNode {
            neighbors = Set(neighbors.flatMap {
                var neighbors: Set<ValveNetwork> = []

                // Option 1: Open valve (if it can be opened)
                if !$0.openNodes.contains(elephantNode) {
                    var neighbor = $0
                    neighbor.flowRate += network[id: elephantNode]!.flowRate
                    neighbor.openNodes.insert(elephantNode)
                    neighbors.insert(neighbor)
                }

                // Option 2: Move to one of the neighbors
                for index in network[id: elephantNode]!.neighbors {
                    var neighbor = $0
                    neighbor.elephantNode = index
                    neighbors.insert(neighbor)
                }

                return neighbors
            })
        }

        return neighbors
    }
}

extension ValveNetwork {
    public init(_ input: String, withPartner: Bool) {
        currentNode = "AA"
        network = IdentifiedArray(uniqueElements: input.split(separator: "\n").map(Node.init))
        openNodes = Set(network.compactMap { $0.flowRate == 0 ? $0.id : nil })
        openNodes.reserveCapacity(network.count)

        if withPartner {
            remainingTime -= 4
            elephantNode = "AA"
        }

        Self.cache = [:]
    }
}
