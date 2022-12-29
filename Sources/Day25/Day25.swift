import AOCAlgorithms

public func snafuSum(_ input: String) -> String {
    let sum = input
        .split(separator: "\n")
        .map { translate($0) }
        .reduce(0, +)
    return translate(sum)
}

public func translate<S: StringProtocol>(_ snafu: S, position: Int = 0) -> Int {
    guard let last = snafu.last else { return 0 }
    let value: Int
    switch last {
    case "=":
        value = -2
    case "-":
        value = -1
    case "0":
        value = 0
    case "1":
        value = 1
    case "2":
        value = 2
    default:
        fatalError("Unrecognized value \(last)")
    }

    let multiplier = 5 ^^ position

    return value * multiplier + translate(snafu.dropLast(), position: position + 1)
}

public func translate(_ int: Int) -> String {
    var int = int

    let chars: [Character] = ["=", "-", "0", "1", "2"]
    var snafuString = ""

    while int != 0 {
        let new = int + 2
        int = new / 5
        snafuString.append(chars[new % 5])
    }

    return String(snafuString.reversed())
}
