import Foundation

@objc public final class FileCertificateResource: NSObject, CertificateLoadableResource {
    let certBundle: Bundle
    let certName: String
    let certExtension: CertExtension

    public init(certBundle: Bundle, certName: String, certExtension: CertExtension) {
        self.certBundle = certBundle
        self.certName = certName
        self.certExtension = certExtension
        super.init()
    }

    public func resourceURL() throws -> URL {
        guard let certUrl = certBundle.url(forResource: certName, withExtension: certExtension.string)
        else { throw missingFileError }
        return certUrl
    }

    public override var hash: Int {
        var hasher = Hasher()
        hasher.combine(certBundle)
        hasher.combine(certName)
        hasher.combine(certExtension)
        return hasher.finalize()
    }

    public var certificateLoader: CertificateLoader {
        return FileCertificateLoader(resource: self)
    }
}

extension FileCertificateResource {
    var missingFileError: DGError {
        let fileError = DGError.File.missing(name: fullFileName, atPath: fileLocation)
        let dgError = DGError.file(fileError)
        return dgError
    }

    func decodingFileError(reason: String) -> Error {
        DGError.File.decoding(name: fullFileName,
                              atPath: fileLocation, reason: reason)

    }
    func readingFileError(reason: String) -> Error {
        DGError.File.reading(name: fullFileName, atPath: fileLocation, reason: reason)
    }

    var fullFileName: String {
        certName + .dot + certExtension.string
    }

    var fileLocation: String {
        certBundle.bundlePath
    }
}
