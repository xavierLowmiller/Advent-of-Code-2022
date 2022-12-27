public func collectGeodesPart1(_ input: String) -> Int {
    var output = 0

    for m in input.matches(of: #/\s*Blueprint (\d+):\s+Each ore robot costs (\d+) ore\.\s+Each clay robot costs (\d+) ore\.\s+Each obsidian robot costs (\d+) ore and (\d+) clay\.\s+Each geode robot costs (\d+) ore and (\d+) obsidian\./#) {
        let blueprint = Blueprint(
            id: Blueprint.ID(m.1)!,
            oreRobotPrice: Int(m.2)!,
            clayRobotPrice: Int(m.3)!,
            obsidianRobotPrice: (Int(m.4)!, Int(m.5)!),
            geodeRobotPrice: (Int(m.6)!, Int(m.7)!)
        )
        let simulation = Simulation(blueprint, minutes: 24)
        var cache: [Inventory: Int] = [:]
        output += simulation.qualityLevel(cache: &cache)
    }

    return output
}

public func collectGeodesPart2(_ input: String) -> Int {
    var output = 1

    for m in input.matches(of: #/\s*Blueprint (\d+):\s+Each ore robot costs (\d+) ore\.\s+Each clay robot costs (\d+) ore\.\s+Each obsidian robot costs (\d+) ore and (\d+) clay\.\s+Each geode robot costs (\d+) ore and (\d+) obsidian\./#).prefix(3) {
        let blueprint = Blueprint(
            id: Blueprint.ID(m.1)!,
            oreRobotPrice: Int(m.2)!,
            clayRobotPrice: Int(m.3)!,
            obsidianRobotPrice: (Int(m.4)!, Int(m.5)!),
            geodeRobotPrice: (Int(m.6)!, Int(m.7)!)
        )
        let simulation = Simulation(blueprint, minutes: 32)
        var cache: [Inventory: Int] = [:]
        output *= simulation.maximumNumberOfGeodes(cache: &cache)
    }

    return output
}

struct Inventory: Hashable {
    var oreRobots = 1
    var clayRobots = 0
    var obsidianRobots = 0
    var geodeRobots = 0

    var ores = 0
    var clay = 0
    var obsidian = 0
    var geodes = 0

    var remainingTime: Int

    mutating func collect() {
        geodes += geodeRobots
        obsidian += obsidianRobots
        clay += clayRobots
        ores += oreRobots
        remainingTime -= 1
    }
}

struct Blueprint: Identifiable {
    init(
        id: Int,
        oreRobotPrice: Int,
        clayRobotPrice: Int,
        obsidianRobotPrice: (ore: Int, clay: Int),
        geodeRobotPrice: (ore: Int, obsidian: Int)
    ) {
        self.id = id
        self.oreRobotPrice = oreRobotPrice
        self.clayRobotPrice = clayRobotPrice
        self.obsidianRobotPrice = obsidianRobotPrice
        self.geodeRobotPrice = geodeRobotPrice

        maxOreBotsNeeded = [oreRobotPrice, clayRobotPrice, obsidianRobotPrice.ore, geodeRobotPrice.ore].max()!
        maxClayBotsNeeded = obsidianRobotPrice.clay
        maxObsidianBotsNeeded = geodeRobotPrice.obsidian
    }

    let id: Int
    let oreRobotPrice: Int
    let clayRobotPrice: Int
    let obsidianRobotPrice: (ore: Int, clay: Int)
    let geodeRobotPrice: (ore: Int, obsidian: Int)

    let maxOreBotsNeeded: Int
    let maxClayBotsNeeded: Int
    let maxObsidianBotsNeeded: Int
}

struct Simulation {
    var inventory: Inventory
    let blueprint: Blueprint

    func maximumNumberOfGeodes(cache: inout [Inventory: Int]) -> Int {
        guard inventory.remainingTime > 0 else { return inventory.geodes }

        if let result = cache[inventory] {
            return result
        } else {
            let result = neighbors.map { $0.maximumNumberOfGeodes(cache: &cache) }.max()!
            cache[inventory] = result
            return result
        }
    }

    func qualityLevel(cache: inout [Inventory: Int]) -> Int {
        maximumNumberOfGeodes(cache: &cache) * blueprint.id
    }
}

extension Simulation {
    init(_ blueprint: Blueprint, minutes: Int) {
        self.inventory = Inventory(remainingTime: minutes)
        self.blueprint = blueprint
    }

    var neighbors: [Simulation] {
        var neighbors: [Simulation] = []

        // Build a geode robot
        if blueprint.geodeRobotPrice.ore <= inventory.ores,
           blueprint.geodeRobotPrice.obsidian <= inventory.obsidian {
            var nextSimulation = self
            nextSimulation.inventory.ores -= blueprint.geodeRobotPrice.ore
            nextSimulation.inventory.obsidian -= blueprint.geodeRobotPrice.obsidian
            nextSimulation.inventory.collect()
            nextSimulation.inventory.geodeRobots += 1
            neighbors.append(nextSimulation)
        } else {

            // Don't build a robot
            var nextSimulation = self
            nextSimulation.inventory.collect()
            neighbors.append(nextSimulation)

            // Build an ore robot
            if blueprint.oreRobotPrice <= inventory.ores,
               blueprint.maxOreBotsNeeded > inventory.oreRobots {
                var nextSimulation = self
                nextSimulation.inventory.ores -= blueprint.oreRobotPrice
                nextSimulation.inventory.collect()
                nextSimulation.inventory.oreRobots += 1
                neighbors.append(nextSimulation)
            }

            // Build a clay robot
            if blueprint.clayRobotPrice <= inventory.ores,
               blueprint.maxClayBotsNeeded > inventory.clayRobots {
                var nextSimulation = self
                nextSimulation.inventory.ores -= blueprint.clayRobotPrice
                nextSimulation.inventory.collect()
                nextSimulation.inventory.clayRobots += 1
                neighbors.append(nextSimulation)
            }

            // Build an obsidian robot
            if blueprint.obsidianRobotPrice.ore <= inventory.ores,
               blueprint.obsidianRobotPrice.clay <= inventory.clay,
               blueprint.maxObsidianBotsNeeded > inventory.obsidianRobots {
                var nextSimulation = self
                nextSimulation.inventory.ores -= blueprint.obsidianRobotPrice.ore
                nextSimulation.inventory.clay -= blueprint.obsidianRobotPrice.clay
                nextSimulation.inventory.collect()
                nextSimulation.inventory.obsidianRobots += 1
                neighbors.append(nextSimulation)
            }
        }

        return neighbors
    }
}
