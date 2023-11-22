import Foundation

extension Optional where Wrapped == CertificateValidationResult {
    var authChallengeResult: AuthChallengeResult {
        switch self {
        case .none:
            return AuthChallengeResult(disposition: .performDefaultHandling,
                                       credential: nil)
        case let .some(result):
            let credential = URLCredential(trust: result.secTrust)
            return AuthChallengeResult(disposition: .useCredential,
                                       credential: credential)
        }
    }
}
