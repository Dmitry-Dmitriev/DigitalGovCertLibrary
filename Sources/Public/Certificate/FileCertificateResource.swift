
import Foundation

final class FileCertificateResource: NSObject, CertificateResource & LoaderProvider {
    let certBundle: Bundle
    let certName: String
    let certExtension: CertExtension
    
    init(certBundle: Bundle, certName: String, certExtension: CertExtension) {
        self.certBundle = certBundle
        self.certName = certName
        self.certExtension = certExtension
    }
    
    func makeURL() throws -> URL {
        guard let certUrl = certBundle.url(forResource: certName, withExtension: certExtension.string)
        else { throw missingFileError }
        return certUrl
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(certBundle)
        hasher.combine(certName)
        hasher.combine(certExtension)
        return hasher.finalize()
    }
    
    func loader(with queue: DispatchQueue) -> CertificateLoader {
        return OnQueueCertificateLoader(queue: queue, closure: FileCertificateLoader(resource: self))
    }
}


private extension FileCertificateResource {
    var missingFileError: DGError {
        DGError.missingFile(name: fullFileName, atPath: fileLocation)
    }
    var decodingFileError: DGError {
        DGError.certDecoding(name: fullFileName,
                                   atPath: fileLocation)

    }
    func readingFileError(reason: String) -> DGError {
        DGError.certReading(name: fullFileName, atPath: fileLocation, reason: reason)
    }

    var fullFileName: String {
        certName + .dot + certExtension.string
    }

    var fileLocation: String {
        certBundle.bundlePath
    }
}
