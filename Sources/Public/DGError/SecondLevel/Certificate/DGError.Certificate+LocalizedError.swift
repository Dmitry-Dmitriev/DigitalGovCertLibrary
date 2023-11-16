import Foundation

extension DGError.Certificate: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case .creation:
            return localizedMessage(key: .dgerrorCode310DescriptionKey)
        case let .validation(error):
            return error.errorDescription
        case let .decoding(error):
            return error.errorDescription
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .creation(data: data):
            return localizedMessage(key: .dgerrorCode310FailureReasonKey, args: [String(data)])
        case let .validation(error):
            return error.failureReason
        case let .decoding(error):
            return error.failureReason
        }
    }

    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case .creation:
            return localizedMessage(key: .dgerrorCode310RecoverySuggestionKey)
        case let .validation(error):
            return error.recoverySuggestion
        case let .decoding(error):
            return error.recoverySuggestion
        }
    }
}

private extension String {
    static let dgerrorCode310DescriptionKey = "dgerror.certificate.creation.code.310.description"
    static let dgerrorCode310FailureReasonKey = "dgerror.certificate.creation.code.310.failureReason"
    static let dgerrorCode310RecoverySuggestionKey = "dgerror.certificate.creation.code.310.recoverySuggestion"
}
