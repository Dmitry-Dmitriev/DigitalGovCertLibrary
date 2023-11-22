//  DigitalGovCertLibrary

//  Copyright (c) 2023-Present DigitalGovCertLibrary Team - https://github.com/myTargetSDK/DigitalGovCertLibrary-iOS
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
                throw DGError.Certificate.Validation.error(error).dgError
            }
        } else {
            var secresult = SecTrustResultType.invalid
            let status = SecTrustEvaluate(serverTrust, &secresult)
            isTrusted = status == errSecSuccess
            if status != errSecSuccess {
                throw DGError.Certificate.Validation.status(status, secResult: secresult).dgError
            }
        }

        return isTrusted
    }
}
