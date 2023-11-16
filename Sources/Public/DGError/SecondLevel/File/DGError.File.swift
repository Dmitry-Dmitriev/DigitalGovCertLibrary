import Foundation

public extension DGError {
    enum File: Error {
        case reading(name: String, atPath: String, reason: String)
        case missing(name: String, atPath: String)
        case decoding(name: String, atPath: String, reason: String)
    }
}
