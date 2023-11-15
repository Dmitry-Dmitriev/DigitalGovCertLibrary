
import Foundation

extension DGError.Certificate.Validation: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error:
            localizedMessage(key: .dgerrorCertValidationErrorCode321DescriptionKey)
        case .status:
            localizedMessage(key: .dgerrorCertValidationStatusCode322DescriptionKey)
        }
    }

    public var failureReason: String? {
        switch self {
        case let .error(error):
            return localizedMessage(key: .dgerrorCertValidationErrorCode321FailureReasonKey, args: [String(error)])
        case let .status(status, secResult: secResult):
            return localizedMessage(key: .dgerrorCertValidationStatusCode322FailureReasonKey, args: [String(status), String(secResult)])
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .error:
            localizedMessage(key: .dgerrorCertValidationErrorCode321RecoverySuggestionKey)
        case .status:
            localizedMessage(key: .dgerrorCertValidationStatusCode322RecoverySuggestionKey)
        }
        
    }
}

private extension String {
    static let dgerrorCertValidationErrorCode321DescriptionKey = "dgerror.certificate.validation.error.code.321.description"
    static let dgerrorCertValidationErrorCode321FailureReasonKey = "dgerror.certificate.validation.error.code.321.failureReason"
    static let dgerrorCertValidationErrorCode321RecoverySuggestionKey = "dgerror.certificate.validation.error.code.321.recoverySuggestion"
    
    static let dgerrorCertValidationStatusCode322DescriptionKey = "dgerror.certificate.validation.status.code.322.description"
    static let dgerrorCertValidationStatusCode322FailureReasonKey = "dgerror.certificate.validation.status.code.322.failureReason"
    static let dgerrorCertValidationStatusCode322RecoverySuggestionKey = "dgerror.certificate.validation.status.code.322.recoverySuggestion"
}

