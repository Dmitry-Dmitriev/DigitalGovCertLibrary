
import Foundation

@objc(DGCertificateValidator)
public final class DigitalGovCertificateValidator: NSObject, URLAuthenticationChallengeValidator {    
    private let loader: LoadingManager<BulkCertificatesLoader>
    
    let shared = DigitalGovCertificateValidator(fileCertificates: .digitalGov)

    convenience init(fileCertificates: [FileCertificateResource]) {
        let bulkLoader = BulkCertificatesLoader(fileResources: fileCertificates)
        self.init(loader: bulkLoader)
    }
    
    convenience init(remoteCertificates: [RemoteCertificateResource]) {
        let bulkLoader = BulkCertificatesLoader(remoteResources: remoteCertificates)
        self.init(loader: bulkLoader)
    }
    
    private init(loader: BulkCertificatesLoader) {
        self.loader = LoadingManager(loader: loader)
    }

    func load() {
        loader.load { _ in }
    }
    
    public func checkValidity(challenge: URLAuthenticationChallenge,
                              completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
       
        loader.load { result in
            if result.isFailed {
                completionHandler(.performDefaultHandling, nil)
                return
            } else {
                let validator = CertificateValidator(certificates: result.certs)
                validator.checkValidity(challenge: challenge, completionHandler: completionHandler)
            }
        }
    }
}
