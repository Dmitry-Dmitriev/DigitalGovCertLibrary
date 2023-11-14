import Foundation

protocol SecTrustValidator {
    func checkValidity(of serverTrust: SecTrust, anchorCertificatesOnly: Bool) throws -> Bool
}
