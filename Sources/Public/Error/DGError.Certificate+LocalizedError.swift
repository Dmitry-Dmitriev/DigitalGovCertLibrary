

import Foundation

extension DGError.Certificate: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .creation:
            return localizedMessage(key: .dgerrorCertificateCreationCode310DescriptionKey)
        case let .validation(error):
            return error.errorDescription
        case let .decoding(error):
            return error.errorDescription
        }
    }
    public var failureReason: String? {
        switch self {
        case let .creation(data: data):
            return localizedMessage(key: .dgerrorCertificateCreationCode310FailureReasonKey, args: [String(data)])
        case let .validation(error):
            return error.failureReason
        case let .decoding(error):
            return error.failureReason
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .creation:
            return localizedMessage(key: .dgerrorCertificateCreationCode310RecoverySuggestionKey)
        case let .validation(error):
            return error.recoverySuggestion
        case let .decoding(error):
            return error.recoverySuggestion
        }
    }
}

private extension String {
    static let dgerrorCertificateCreationCode310DescriptionKey = "dgerror.certificate.creation.code.310.description"
    static let dgerrorCertificateCreationCode310FailureReasonKey = "dgerror.certificate.creation.code.310.failureReason"
    static let dgerrorCertificateCreationCode310RecoverySuggestionKey = "dgerror.certificate.creation.code.310.recoverySuggestion"
}
