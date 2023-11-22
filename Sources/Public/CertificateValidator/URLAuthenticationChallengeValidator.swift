import Foundation

/// Any object that can validate authenticate challenge
@objc public protocol URLAuthenticationChallengeValidator: NSObjectProtocol {
    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (CertificateValidationResult?) -> Void)

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async -> CertificateValidationResult?
}
