
import Foundation

extension DGError.Certificate.Validation: LocalizedError {
    public var errorDescription: String? {
        return "Error is occured on certiicate(s) validation."
    }

    public var failureReason: String? {
        switch self {
        case let .error(error):
            return "Reason: \(error)"
        case let .status(status, secResult: secResult):
            return "Reason: certificate validation failed with OSStatus \(status) secTrustResultType \(secResult)"
        }
    }
    public var recoverySuggestion: String? {
        return "Try to use another certificate(s)."
    }
}
