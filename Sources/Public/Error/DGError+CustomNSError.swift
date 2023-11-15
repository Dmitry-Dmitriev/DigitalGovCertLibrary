import Foundation

// MARK: - CustomNSError
extension DGError: CustomNSError {
    public var errorCode: Int {
        switch self {
        case let .file(error):
            return 1 * globalErrorCodeLevel + error.errorCode
        case let .network(error):
            return 2 * globalErrorCodeLevel + error.errorCode
        case let .certificate(error):
            return 3 * globalErrorCodeLevel + error.errorCode
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
