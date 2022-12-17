import XCTest
import Day16

final class Day16Tests: XCTestCase {
    func testPart1Example() {
        let input = """
        Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
        Valve BB has flow rate=13; tunnels lead to valves CC, AA
        Valve CC has flow rate=2; tunnels lead to valves DD, BB
        Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
        Valve EE has flow rate=3; tunnels lead to valves FF, DD
        Valve FF has flow rate=0; tunnels lead to valves EE, GG
        Valve GG has flow rate=0; tunnels lead to valves FF, HH
        Valve HH has flow rate=22; tunnel leads to valve GG
        Valve II has flow rate=0; tunnels lead to valves AA, JJ
        Valve JJ has flow rate=21; tunnel leads to valve II
        """

        let network = ValveNetwork(input, withPartner: false)

        XCTAssertEqual(network.maxSteamReleased, 1651)
    }

    func testPart2Example() {
        let input = """
        Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
        Valve BB has flow rate=13; tunnels lead to valves CC, AA
        Valve CC has flow rate=2; tunnels lead to valves DD, BB
        Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
        Valve EE has flow rate=3; tunnels lead to valves FF, DD
        Valve FF has flow rate=0; tunnels lead to valves EE, GG
        Valve GG has flow rate=0; tunnels lead to valves FF, HH
        Valve HH has flow rate=22; tunnel leads to valve GG
        Valve II has flow rate=0; tunnels lead to valves AA, JJ
        Valve JJ has flow rate=21; tunnel leads to valve II
        """

        let network = ValveNetwork(input, withPartner: true)

        XCTAssertEqual(network.maxSteamReleased, 1707)
    }

    func testDay16Part1() {
        let network = ValveNetwork(input, withPartner: false)
        print("Day 16 Part 1:", network.maxSteamReleased)
    }

    func testDay16Part2() {
        let network = ValveNetwork(input, withPartner: true)
        print("Day 16 Part 2:", network.maxSteamReleased)
    }
}
