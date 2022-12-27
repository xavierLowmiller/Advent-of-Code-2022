func totalOverlaps(of input: String) -> Int {
    input.ranges.filter { $0.contains($1) || $1.contains($0) }.count
}

func partialOverlaps(of input: String) -> Int {
    input.ranges.filter { $0.overlaps($1) }.count
}

private extension StringProtocol where SubSequence == Substring {
    var ranges: [(ClosedRange<Int>, ClosedRange<Int>)] {
        split(separator: "\n").map(\.rangeTuple)
    }

    private var rangeTuple: (ClosedRange<Int>, ClosedRange<Int>) {
        let d = wholeMatch(of: #/(\d+)-(\d+),(\d+)-(\d+)/#)!
        return (Int(d.1)!...Int(d.2)!, Int(d.3)!...Int(d.4)!)
    }
}

private extension ClosedRange {
    func contains(_ other: ClosedRange<Bound>) -> Bool {
        clamped(to: other) == self
    }
}
