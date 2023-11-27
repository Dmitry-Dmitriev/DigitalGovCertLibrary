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

/// Object that loads certificates resources from file or from network and
@objc(DGCertificateValidator)
public final class DigitalGovCertificateValidator: NSObject, URLAuthenticationChallengeValidator {
    private let oneTimeLoader: OneTimeLoader<BulkCertificatesLoader>

    @objc
    public static let shared = DigitalGovCertificateValidator(fileCertificates: .digitalGov)

    /// Convenience initializer to load certificates from files
    @objc
    public convenience init(fileCertificates: [FileCertificateResource]) {
        let bulkLoader = BulkCertificatesLoader(fileResources: fileCertificates)
        self.init(certificateLoader: bulkLoader)
    }

    /// Convenience initializer to load certificates from remote
    @objc
    public convenience init(remoteCertificates: [RemoteCertificateResource]) {
        let bulkLoader = BulkCertificatesLoader(remoteResources: remoteCertificates)
        self.init(certificateLoader: bulkLoader)
    }

    private init(certificateLoader: BulkCertificatesLoader) {
        self.oneTimeLoader = OneTimeLoader(loader: certificateLoader)
        super.init()
    }

    /// Speeds up certificates load from resources. Multiple call of the method does nothing
    @objc public func load() {
        oneTimeLoader.load { _ in }
    }

    /// Validates authentication challenge
    /// - Parameters:
    ///    - challenge: authentication challenge (from URLSessionDelegate or WKNavigationDelegate)
    ///    - completionHandler: The completion handler that is invoked to respond to the challenge
    @objc
    public func checkValidity(challenge: URLAuthenticationChallenge,
                              completionHandler: @escaping (CertificateValidationResult?) -> Void) {

        oneTimeLoader.load { result in
            guard !result.isFailed else {
                completionHandler(nil)
                return
            }

            do {
                let secTrustValidator: SecTrustValidator = CertSecTrustValidator(certificates: result.certs)
                let validator: CertAuthChallengeValidator = CertificateValidator(secTrustValidator: secTrustValidator)
                try validator.checkValidity(challenge: challenge, completionHandler: completionHandler)
            } catch {
                completionHandler(nil)
            }
        }
    }

    /// Convenience method to direct call from URLSessionDelegate or WKNavigationDelegate
    /// You can write similiar extension with custom converting from
    /// CertificateValidationResult to (URLSession.AuthChallengeDisposition, URLCredential?)
    @objc
    public func checkValidity(_ challenge: URLAuthenticationChallenge,
                              completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        checkValidity(challenge: challenge) { result  in
            let authChallengeResult = result.authChallengeResult
            completionHandler(authChallengeResult.disposition,
                              authChallengeResult.credential)
        }
    }
}
