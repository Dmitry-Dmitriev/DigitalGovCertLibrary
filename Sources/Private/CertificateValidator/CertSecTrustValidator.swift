

import Foundation

final class CertSecTrustValidator: SecTrustValidator {
    private let certificates: [SecCertificate]

    init(certificates: [Certificate]) {
        self.certificates = certificates.map { $0.certificate }
    }

    func checkValidity(of serverTrust: SecTrust, anchorCertificatesOnly: Bool = false) throws -> Bool {
        SecTrustSetAnchorCertificates(serverTrust, certificates as CFArray)
        SecTrustSetAnchorCertificatesOnly(serverTrust, anchorCertificatesOnly)

        var error: CFError?
        var isTrusted = false
        if #available(macOS 10.14, *) {
            isTrusted = SecTrustEvaluateWithError(serverTrust, &error)
            if let error {
                throw DGError.Certificate.Validation.error(error)
            }
        } else {
            var secresult = SecTrustResultType.invalid
            let status = SecTrustEvaluate(serverTrust, &secresult)
            isTrusted = status == errSecSuccess
            if status != errSecSuccess {
                throw DGError.Certificate.Validation.status(status, secResult: secresult)
            }
        }

        return isTrusted
    }
}
