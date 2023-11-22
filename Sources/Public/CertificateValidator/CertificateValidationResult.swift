import Foundation

@objc(CertificateValidationResult)
public final class CertificateValidationResult: NSObject {
    /// the value of URLAuthenticationChallenge.protectionSpace.serverTrust
    @objc
    public let secTrust: SecTrust
    /// the result of function call SecTrustEvaluateWithError(trust, &error) or SecTrustEvaluate(trust, &secresult)
    @objc
    public let isTrusted: Bool

    init?(secTrust: SecTrust?,
          isTrusted: Bool) {
        guard let secTrust else {
            return nil
        }
        self.secTrust = secTrust
        self.isTrusted = isTrusted
        super.init()
    }
}
