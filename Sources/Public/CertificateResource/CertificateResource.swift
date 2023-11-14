import Foundation

@objc public protocol CertificateResource: NSObjectProtocol {
    func resourceURL() throws -> URL
}
