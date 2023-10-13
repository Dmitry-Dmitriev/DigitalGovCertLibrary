//
//  CertificateValidator.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 28.09.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

final class SecTrustValidator {
    private let certificates: [SecCertificate]

    init(certificates: [Certificate]) {
        self.certificates = certificates.map { $0.certificate }
    }

    func checkValidity(of serverTrust: SecTrust, anchorCertificatesOnly: Bool = false) -> Bool {
        SecTrustSetAnchorCertificates(serverTrust, certificates as CFArray)
        SecTrustSetAnchorCertificatesOnly(serverTrust, anchorCertificatesOnly)

        var error: CFError?
        var isTrusted = false
        if #available(macOS 10.14, *) {
            isTrusted = SecTrustEvaluateWithError(serverTrust, &error)
        } else {
            var secresult = SecTrustResultType.invalid
            let status = SecTrustEvaluate(serverTrust, &secresult)
            isTrusted = status == errSecSuccess
        }

        return isTrusted
    }
}
