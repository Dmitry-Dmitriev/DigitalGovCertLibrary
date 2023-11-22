import Foundation

final class CertificateValidator: CertAuthChallengeValidator {
    private let secTrustValidator: SecTrustValidator

    init(secTrustValidator: SecTrustValidator) {
        self.secTrustValidator = secTrustValidator
    }

    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (CertificateValidationResult?) -> Void) throws {
        guard let trust = challenge.protectionSpace.serverTrust else {
            completionHandler(nil)
            return
        }

        let isTrusted = try secTrustValidator.checkValidity(of: trust, anchorCertificatesOnly: false)
        let certificateValidationResult = CertificateValidationResult(secTrust: trust, isTrusted: isTrusted)
        completionHandler(certificateValidationResult)
    }

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async throws -> (CertificateValidationResult?) {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try checkValidity(challenge: challenge) { certificateValidationResult in
                    continuation.resume(returning: certificateValidationResult)
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
