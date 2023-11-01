
import Foundation

@objc(DGCertificateValidator)
public final class DigitalGovCertificateValidator: NSObject, URLAuthenticationChallengeValidator {    
    private let loader: OneTimeLoader<BulkCertificatesLoader>
    
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
        self.loader = OneTimeLoader(loader: certificateLoader)
        super.init()
    }

    func load() {
        loader.load { _ in }
    }
    
    public func checkValidity(challenge: URLAuthenticationChallenge,
                              completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        loader.load { result in
            guard !result.isFailed else {
                completionHandler(.performDefaultHandling, nil)
                return
            } 
            
            do {
                let validator = CertificateValidator(certificates: result.certs)
                try validator.checkValidity(challenge: challenge, completionHandler: completionHandler)
            }
            catch {
                completionHandler(.performDefaultHandling, nil)
            }
        }
    }
}
