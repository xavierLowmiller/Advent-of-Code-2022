/// Finds the packet header marker in a datastream buffer
///
/// The header is a String of 4 non-repeating characters
/// - Parameter input: A String representing a datastream buffer
/// - Returns: The location of the last character of the marker. 1-indexed
public func findBeginningOfPacket(_ input: String) -> Int {
    return input.findEndOfNonRepeatingSequence(of: 4)
}

/// Finds the message start marker of a datastream buffer
///
/// The message start marker is a String of 14 non-repeating characters
/// - Parameter input: A String representing a message
/// - Returns: The location of the last character of the marker. 1-indexed
public func findBeginningOfMessage(_ input: String) -> Int {
    return input.findEndOfNonRepeatingSequence(of: 14)
}

private extension String {
    func findEndOfNonRepeatingSequence(of length: Int) -> Int {

        for index in 0... {
            if Set(dropFirst(index).prefix(length)).count == length {
                return index + length
            }
        }

        fatalError("No non-repeating sequence of length \(length) was found")
    }
}
