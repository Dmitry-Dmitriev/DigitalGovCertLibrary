import Foundation

protocol CertAuthChallengeValidator: AnyObject {
    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) throws

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async throws -> (URLSession.AuthChallengeDisposition, URLCredential?)
}
