
import Foundation

@objc public protocol CertificateResource: NSObjectProtocol {
    func makeURL() throws -> URL
}
