import Foundation

protocol SecTrustValidator: AnyObject {
    func checkValidity(of serverTrust: SecTrust, anchorCertificatesOnly: Bool) throws -> Bool
}
