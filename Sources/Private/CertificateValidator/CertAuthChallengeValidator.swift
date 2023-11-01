
import Foundation

protocol CertAuthChallengeValidator: AnyObject {
    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) throws
}
