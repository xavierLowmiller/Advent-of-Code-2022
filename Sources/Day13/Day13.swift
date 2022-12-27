func scoreOfPairsInTheRightOrder(_ input: String) -> Int {
    let pairs = input.split(separator: "\n\n").map {
        let l1 = List($0.split(separator: "\n")[0])!
        let l2 = List($0.split(separator: "\n")[1])!

        return (l1, l2)
    }

    return zip(1..., pairs.map(<)).reduce(into: 0) {
        let (index, isInRightOrder) = $1
        if isInRightOrder { $0 += index }
    }
}

func decoderKey(_ input: String) -> Int {
    let dividerPacket1: List = [[2]]
    let dividerPacket2: List = [[6]]

    let elementsFromInput = input.split(separator: "\n").compactMap(List.init)

    let allElements = (elementsFromInput + [dividerPacket1, dividerPacket2])
        .sorted()

    let i1 = allElements.firstIndex(of: dividerPacket1)!
    let i2 = allElements.firstIndex(of: dividerPacket2)!
    return (i1 + 1) * (i2 + 1)
}

public enum List: Equatable {
    case list([List])
    case literal(Int)

    init?<S: StringProtocol>(_ input: S) where S.SubSequence == Substring {
        var input = input[...]
        guard let list = List(&input) else { return nil }
        self = list
        assert(input.isEmpty)
    }

    init?(_ input: inout Substring) {
        if input.first == "[" {
            input.removeFirst()
            var nodes: [List] = []
            while !input.isEmpty, let node = List(&input) {
                nodes.append(node)
            }
            self = .list(nodes)
        } else if input.first == "]" {
            input.removeFirst()
            if input.first == "," { input.removeFirst() }
            return nil
        } else if input.first?.isWholeNumber == true {
            let number = input.prefix(while: \.isWholeNumber)
            input.removeFirst(number.count)
            if input.first == "," { input.removeFirst() }
            self = .literal(Int(number)!)
        } else {
            fatalError("Unexpected input \(input)")
        }
    }
}

extension List: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.literal(l1), .literal(l2)):
            return l1 < l2
        case let (.list(l1), .list(l2)):
            return l1 < l2
        case let (.list(list), .literal):
            return list < [rhs]
        case let (.literal, .list(list)):
            return [lhs] < list
        }
    }
}

extension Array: Comparable where Element == List {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        for (l1, l2) in zip(lhs, rhs) {
            if l1 < l2 {
                return true
            }
            if l1 > l2 {
                return false
            }
        }

        return lhs.count < rhs.count
    }
}

extension List: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: IntegerLiteralType) {
        self = .literal(value)
    }
}

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: List...) {
        self = .list(Array(elements))
    }
}
