import Foundation

public extension DigitalGovCertificateValidator {
    /// Convenience method to direct call from URLSessionDelegate or WKNavigationDelegate
    /// You can write similiar extension with custom converting from
    /// CertificateValidationResult to (URLSession.AuthChallengeDisposition, URLCredential?)
    @objc
    func checkValidity(_ challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        checkValidity(challenge: challenge) { result  in
            let authChallengeResult = result.authChallengeResult
            completionHandler(authChallengeResult.disposition,
                              authChallengeResult.credential)
        }
    }

    /// Async / await version of checkValidity(_ challenge: completionHandler: )
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        await withCheckedContinuation { continuation in
            checkValidity(challenge) { disposition, credential in
                continuation.resume(returning: (disposition, credential))
            }
        }
    }
}
