import Foundation

@objc(DGCertificateValidator)
public final class DigitalGovCertificateValidator: NSObject, URLAuthenticationChallengeValidator {
    private let oneTimeLoader: OneTimeLoader<BulkCertificatesLoader>

    let shared = DigitalGovCertificateValidator(fileCertificates: .digitalGov)

    convenience init(fileCertificates: [FileCertificateResource]) {
        let bulkLoader = BulkCertificatesLoader(fileResources: fileCertificates)
        self.init(certificateLoader: bulkLoader)
    }

    convenience init(remoteCertificates: [RemoteCertificateResource]) {
        let bulkLoader = BulkCertificatesLoader(remoteResources: remoteCertificates)
        self.init(certificateLoader: bulkLoader)
    }

    private init(certificateLoader: BulkCertificatesLoader) {
        self.oneTimeLoader = OneTimeLoader(loader: certificateLoader)
        super.init()
    }

    public func load() {
        oneTimeLoader.load { _ in }
    }

    public func checkValidity(challenge: URLAuthenticationChallenge,
                              completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        oneTimeLoader.load { result in
            guard !result.isFailed else {
                completionHandler(.performDefaultHandling, nil)
                return
            }

            do {
                let validator = CertificateValidator(certificates: result.certs)
                try validator.checkValidity(challenge: challenge, completionHandler: completionHandler)
            } catch {
                completionHandler(.performDefaultHandling, nil)
            }
        }
    }

    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    public func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        await withCheckedContinuation { continuation in
            checkValidity(challenge: challenge) { disposition, credentials in
                continuation.resume(returning: (disposition, credentials))
            }
        }
    }
}
