import Foundation

extension DGError.Certificate.Validation: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case .error:
            localizedMessage(key: .dgerrorCode321DescriptionKey)
        case .status:
            localizedMessage(key: .dgerrorCode322DescriptionKey)
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .error(error):
            return localizedMessage(key: .dgerrorCode321FailureReasonKey, args: [String(error)])
        case let .status(status, secResult: secResult):
            return localizedMessage(key: .dgerrorCode322FailureReasonKey, args: [String(status), String(secResult)])
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case .error:
            localizedMessage(key: .dgerrorCode321RecoverySuggestionKey)
        case .status:
            localizedMessage(key: .dgerrorCode322RecoverySuggestionKey)
        }

    }
}

private extension String {
    static let dgerrorCode321DescriptionKey = "dgerror.certificate.validation.error.code.321.description"
    static let dgerrorCode321FailureReasonKey = "dgerror.certificate.validation.error.code.321.failureReason"
    static let dgerrorCode321RecoverySuggestionKey = "dgerror.certificate.validation.error.code.321.recoverySuggestion"

    static let dgerrorCode322DescriptionKey = "dgerror.certificate.validation.status.code.322.description"
    static let dgerrorCode322FailureReasonKey = "dgerror.certificate.validation.status.code.322.failureReason"
    static let dgerrorCode322RecoverySuggestionKey = "dgerror.certificate.validation.status.code.322.recoverySuggestion"
}
