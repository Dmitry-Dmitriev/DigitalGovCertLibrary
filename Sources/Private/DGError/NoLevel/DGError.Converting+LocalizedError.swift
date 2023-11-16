import Foundation

extension DGError.Converting: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .stringFromData:
            return localizedMessage(key: .dgerror10DescriptionKey)
        case .dataFromBase64:
            return localizedMessage(key: .dgerrorCode11DescriptionKey)
        case .urlFromString:
            return localizedMessage(key: .dgerror12DescriptionKey)
        }
    }

    var failureReason: String? {
        switch self {
        case let .stringFromData(data):
            return localizedMessage(key: .dgerror10FailureReasonKey, args: [String(data)])
        case let .dataFromBase64(string):
            return localizedMessage(key: .dgerrorCode11FailureReasonKey, args: [string])
        case let .urlFromString(string):
            return localizedMessage(key: .dgerror12FailureReasonKey, args: [string])
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .stringFromData:
            return localizedMessage(key: .dgerror10RecoverySuggestionKey)
        case .dataFromBase64:
            return localizedMessage(key: .dgerrorCode11RecoverySuggestionKey)
        case .urlFromString:
            return localizedMessage(key: .dgerror12RecoverySuggestionKey)
        }
    }
}

private extension String {
    static let dgerror10DescriptionKey = "dgerror.convering.code.10.description"
    static let dgerror10FailureReasonKey = "dgerror.convering.code.10.failureReason"
    static let dgerror10RecoverySuggestionKey = "dgerror.convering.code.10.recoverySuggestion"

    static let dgerrorCode11DescriptionKey = "dgerror.converting.code.11.description"
    static let dgerrorCode11FailureReasonKey = "dgerror.converting.code.11.failureReason"
    static let dgerrorCode11RecoverySuggestionKey = "dgerror.converting.code.11.recoverySuggestion"

    static let dgerror12DescriptionKey = "dgerror.converting.code.12.description"
    static let dgerror12FailureReasonKey = "dgerror.converting.code.12.failureReason"
    static let dgerror12RecoverySuggestionKey = "dgerror.converting.code.12.recoverySuggestion"
}
