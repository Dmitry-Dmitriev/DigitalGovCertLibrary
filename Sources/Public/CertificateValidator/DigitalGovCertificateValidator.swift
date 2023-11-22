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

    /// Async / await version of checkValidity(challenge: completionHandler: )
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    public func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async -> CertificateValidationResult? {
        await withCheckedContinuation { continuation in
            checkValidity(challenge: challenge) { certificateValidationResult in
                continuation.resume(returning: certificateValidationResult)
            }
        }
    }
}
