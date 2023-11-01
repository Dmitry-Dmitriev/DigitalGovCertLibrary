

import Foundation

// MARK: - CustomNSError
extension DGError: CustomNSError {
    public var errorCode: Int {
        switch self {
        case let .file(error):
            return 1 * multiplier + error.errorCode
        case let .network(error):
            return 2 * multiplier + error.errorCode
        case let .converting(error):
            return 3 * multiplier + error.errorCode
        case let .certificate(error):
            return 4 * multiplier + error.errorCode
        }
    }
}

extension CustomNSError where Self: LocalizedError {
    public static var errorDomain: String {
        return String(Self.self)
    }
    
    public var errorUserInfo: [String: Any] {
        var errorUserInfo = [String: Any]()
        if let errorDescription {
            errorUserInfo[NSLocalizedDescriptionKey] = errorDescription
        }
        if let failureReason {
            errorUserInfo[NSLocalizedFailureReasonErrorKey] = failureReason
        }
        if let recoverySuggestion {
            errorUserInfo[NSLocalizedRecoverySuggestionErrorKey] = recoverySuggestion
        }
        return errorUserInfo
    }
}
