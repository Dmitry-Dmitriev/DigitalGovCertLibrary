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
        let certUrl = certBundle.url(forResource: certName, withExtension: certExtension.string)
        guard let certUrl else {
            throw DGError.File.missing(name: fullFileName, atPath: fileLocation).dgError
        }
        return certUrl
    }

    public var certificateLoader: CertificateLoader {
        return FileCertificateLoader(resource: self)
    }
}

extension FileCertificateResource {
    var fullFileName: String {
        certName + .dot + certExtension.string
    }

    var fileLocation: String {
        certBundle.bundlePath
    }
}
