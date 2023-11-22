import Foundation

protocol CertAuthChallengeValidator: AnyObject {
    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (CertificateValidationResult?) -> Void) throws

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async throws -> (CertificateValidationResult?)
}
