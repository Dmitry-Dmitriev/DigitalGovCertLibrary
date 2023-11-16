import Foundation

extension CustomNSError where Self: LocalizedError {
    /// Default implementation of errorDomain property
    public static var errorDomain: String {
        return String(Self.self)
    }

    /// Default implementation of errorUserInfo property
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
