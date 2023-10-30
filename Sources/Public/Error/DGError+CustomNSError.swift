

import Foundation

// MARK: - CustomNSError
extension DGError: CustomNSError {
    public static var errorDomain: String { return
        String(Self.self)
    }

    public var errorCode: Int {
        switch self {
        case .missingFile: return 1
        case .certDecoding: return 2
        case .certReading: return 3
        }
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
