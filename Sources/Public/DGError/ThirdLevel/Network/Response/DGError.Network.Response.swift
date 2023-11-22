import Foundation

/// Network's response  errors
public extension DGError.Network {
    enum Response: Error {
        case unexpected(type: String)
        case error(_ error: Error)
    }
}
