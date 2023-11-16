import Foundation

/// Wrapper to use SecCertificate array in obj-c
@objc public final class Certificate: NSObject {
    /// SecCertificate property
    @objc public let certificate: SecCertificate

    internal init(certificate: SecCertificate) {
        self.certificate = certificate
        super.init()
    }
}
