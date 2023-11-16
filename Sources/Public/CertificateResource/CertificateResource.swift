import Foundation

/// Certificate resource that can be loaded by url
@objc public protocol CertificateResource: NSObjectProtocol {
    /// Certificate's resource url
    func resourceURL() throws -> URL
}
