public func bfs<Node: Hashable, S: Sequence<Node>>(
    start: Node,
    goal: Node,
    neighbors: (Node) -> S
) -> [Node]? {
    bfs(start: start, goal: { $0 == goal }, neighbors: neighbors)
}

public func bfs<Node: Hashable, S: Sequence<Node>>(
    start: Node,
    goal: (Node) -> Bool,
    neighbors: (Node) -> S
) -> [Node]? {
    var queue: [Node] = [start]
    var explored: Set<Node> = [start]

    // For node n, cameFrom[n] is the node immediately preceding it
    // on the cheapest path from start to n currently known.
    var cameFrom: [Node: Node] = [:]

    while !queue.isEmpty {
        let node = queue.removeFirst()

        guard !goal(node) else {
            return cameFrom.reconstructPath(to: node)
        }

        for neighbor in neighbors(node) {
            guard !explored.contains(neighbor) else { continue }
            explored.insert(neighbor)
            cameFrom[neighbor] = node

            queue.append(neighbor)
        }
    }

    return nil
}

extension Dictionary where Key == Value {
    func reconstructPath(to value: Value) -> [Value] {
       var current = value
       var totalPath = [current]
       while let value = self[current] {
           current = value
           totalPath.append(value)
       }
       return totalPath.reversed()
   }
}
