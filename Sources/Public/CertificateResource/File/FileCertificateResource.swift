import Foundation

/// Certificate resource that can be loaded from file
@objc public final class FileCertificateResource: NSObject, CertificateLoadableResource {
    let certBundle: Bundle
    let certName: String
    let certExtension: CertExtension

    /// Designated initializer
    /// - Parameters:
    ///    - certBundle: bundle where certificate is located
    ///    - certName: name of certificate
    ///    - certExtension: extension of certificate
    public init(certBundle: Bundle, certName: String, certExtension: CertExtension) {
        self.certBundle = certBundle
        self.certName = certName
        self.certExtension = certExtension
        super.init()
    }

    /// Certiicate resource url to file
    public func resourceURL() throws -> URL {
        let certUrl = certBundle.url(forResource: certName, withExtension: certExtension.string)
        guard let certUrl else {
            let error = DGError.File.missing(name: fullFileName,
                                             atPath: fileLocation)
            throw error.dgError
        }
        return certUrl
    }

    /// Certificate loader of file resource
    public var certificateLoader: CertificateLoader {
        return FileCertificateLoader(resource: self)
    }
}

private extension FileCertificateResource {
    var fullFileName: String {
        certName + .dot + certExtension.string
    }

    var fileLocation: String {
        certBundle.bundlePath
    }
}
