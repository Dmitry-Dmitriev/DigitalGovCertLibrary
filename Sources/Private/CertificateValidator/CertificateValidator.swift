
import Foundation

final class CertificateValidator: CertAuthChallengeValidator {
    private let secTrustValidator: SecTrustValidator

    init(certificates: [Certificate]) {
        self.secTrustValidator = CertSecTrustValidator(certificates: certificates)
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
}
