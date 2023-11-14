
import Foundation

extension DGError.Network: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .request(requestProvider, error: _):
            if let request = try? requestProvider.request {
                return "Request \(request) fails."
            } else {
               return "It is not possible create request from requestProvider \(requestProvider)."
            }
        case let .response(error):
            return error.errorDescription
        }
    }
    public var failureReason: String? {
        switch self {
        case let .request(_, error: error):
            return "Reason: \"\(error)\"."
        case let .response(error):
            return error.failureReason
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case let .request(_, error: error):
            return "Try to fix the error: \"\(error)\"."
        case let .response(error):
            return error.recoverySuggestion
        }
    }
}
