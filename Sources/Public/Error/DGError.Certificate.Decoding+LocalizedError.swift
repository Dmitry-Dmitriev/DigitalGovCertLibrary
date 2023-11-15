
import Foundation

extension DGError.Certificate.Decoding: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .pem(error):
            return localizedMessage(key: .dgerrorCertDecodingPemErrorCode331DescriptionKey, args: [String(error)])
        case let .der(error):
            return localizedMessage(key: .dgerrorCertDecodingDerCode332DescriptionKey, args: [String(error)])
        case .universal:
            return localizedMessage(key: .dgerrorCertDecodingUniversalCode333DescriptionKey)
        }
    }
    
    public var failureReason: String? {
        switch self {
        case let .pem(error):
            return localizedMessage(key: .dgerrorCertDecodingPemErrorCode331FailureReasonKey, args: [String(error)])
        case let .der(error):
            return localizedMessage(key: .dgerrorCertDecodingDerCode332FailureReasonKey, args: [String(error)])
        case let .universal(results):
            let reasons = results.compactMap { result in
                if case let .failure(error) = result {
                    return String(error)
                }
                return nil
            }
            return localizedMessage(key: .dgerrorCertDecodingUniversalCode333FailureReasonKey, args: reasons)
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case let .pem(error):
            return localizedMessage(key: .dgerrorCertDecodingPemErrorCode331RecoverySuggestionKey, args: [String(error)])
        case let .der(error):
            return localizedMessage(key: .dgerrorCertDecodingDerCode332RecoverySuggestionKey, args: [String(error)])
        case let .universal(results):
            let reasons = results.compactMap { result in
                if case let .failure(error) = result {
                    return String(error)
                }
                return nil
            }
            return localizedMessage(key: .dgerrorCertDecodingUniversalCode333FailureReasonKey, args: reasons)
        }
    }
}

private extension String {
    static let dgerrorCertDecodingPemErrorCode331DescriptionKey = "dgerror.certificate.decoding.pem.code.331.description"
    static let dgerrorCertDecodingPemErrorCode331FailureReasonKey = "dgerror.certificate.decoding.pem.code.331.failureReason"
    static let dgerrorCertDecodingPemErrorCode331RecoverySuggestionKey = "dgerror.certificate.decoding.pem.code.331.recoverySuggestion"
    
    static let dgerrorCertDecodingDerCode332DescriptionKey = "dgerror.certificate.decoding.der.code.332.description"
    static let dgerrorCertDecodingDerCode332FailureReasonKey = "dgerror.certificate.decoding.der.code.332.failureReason"
    static let dgerrorCertDecodingDerCode332RecoverySuggestionKey = "dgerror.certificate.decoding.der.code.332.recoverySuggestion"
    
    static let dgerrorCertDecodingUniversalCode333DescriptionKey = "dgerror.certificate.decoding.universal.code.333.description"
    static let dgerrorCertDecodingUniversalCode333FailureReasonKey = "dgerror.certificate.decoding.universal.code.333.failureReason"
    static let dgerrorCertDecodingUniversalCode333RecoverySuggestionKey = "dgerror.certificate.decoding.universal.code.333.recoverySuggestion"
}
