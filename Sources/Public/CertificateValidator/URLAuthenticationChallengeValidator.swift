import Foundation

@objc public protocol URLAuthenticationChallengeValidator: NSObjectProtocol {
    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?)
}
