func gcd(_ a: Int, _ b: Int) -> Int {
    if a == 0 {
        return b
    }
    if b == 0 {
        return a
    }

    let (a, b) = (max(a, b), min(a, b))

    assert(a >= b)

    return gcd(b, a % b)
}

func lcm(_ a: Int, _ b: Int) -> Int {
    guard a != 0 && b != 0 else { return 0 }

    return a * (b / gcd(a, b))
}
