import Foundation

/// no docs
@objc public final class Certificate: NSObject {
    /// no docs
    @objc public let certificate: SecCertificate

    internal init(certificate: SecCertificate) {
        self.certificate = certificate
        super.init()
    }
}
