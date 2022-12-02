struct RPSGame {
    let rounds: [(RPS, RPS)]
    init(_ input: String, isPart1: Bool) {
        let rounds = input.split(separator: "\n")
        if isPart1 {
            self.rounds = rounds.map { round in
                (RPS(round.first!), RPS(round.last!))
            }
        } else {
            self.rounds = rounds.map { round in
                let opponentsPlay = RPS(round.first!)
                switch round.last {
                case "X": // needs to lose
                    return (opponentsPlay, opponentsPlay.wouldWinAgainst)
                case "Y": // needs to draw
                    return (opponentsPlay, opponentsPlay)
                case "Z": // needs to win
                    return (opponentsPlay, opponentsPlay.wouldLoseAgainst)
                default:
                    fatalError()
                }
            }
        }
    }

    func calculateScore() -> Int {
        rounds.reduce(0) {
            $0 + $1.1.value + $1.1.outcome(against: $1.0)
        }
    }
}

enum RPS {
    case rock
    case paper
    case scissors

    init(_ character: Character) {
        switch character {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self = .paper
        case "C", "Z":
            self = .scissors
        default:
            fatalError()
        }
    }

    var wouldWinAgainst: RPS {
        switch self {
        case .rock:
            return .scissors
        case .paper:
            return .rock
        case .scissors:
            return .paper
        }
    }

    var wouldLoseAgainst: RPS {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scissors
        case .scissors:
            return .rock
        }
    }

    var value: Int {
        switch self {
        case .rock:
            return 1
        case .paper:
            return 2
        case .scissors:
            return 3
        }
    }

    func outcome(against rps: RPS) -> Int {
        switch (self, rps) {
        case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
            return 6
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return 3
        case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
            return 0
        }
    }
}
