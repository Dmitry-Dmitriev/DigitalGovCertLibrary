
import Foundation

extension DGError.Network.Response: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .unexpected(type):
            "Unexpected response body type. \(type) is expected. Empty body is received."
        }
    }
    public var failureReason: String? {
        switch self {
        case .unexpected:
            "Server does not send response body."
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case let .unexpected(type):
            "Ask backend developer to send response body of type \(type) or choose another server endpoint."
        }
    }
}
