import Foundation

final class CertificateValidator: CertAuthChallengeValidator {
    private let secTrustValidator: SecTrustValidator

    init(secTrustValidator: SecTrustValidator) {
        self.secTrustValidator = secTrustValidator
    }

    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) throws {
        guard let trust = challenge.protectionSpace.serverTrust else {
            completionHandler(.performDefaultHandling, nil)
            return
        }

        let isTrusted = try secTrustValidator.checkValidity(of: trust, anchorCertificatesOnly: false)
        let authChallengeDisposition: URLSession.AuthChallengeDisposition = isTrusted ? .useCredential : .performDefaultHandling
        let credentials: URLCredential? = isTrusted ? .init(trust: trust) : nil
        completionHandler(authChallengeDisposition, credentials)
    }

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async throws -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        try await withCheckedThrowingContinuation { continuation in
            do {
                try checkValidity(challenge: challenge) { disposition, credentials in
                    continuation.resume(returning: (disposition, credentials))
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
