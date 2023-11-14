import Foundation

@objc public protocol CertFormatDecoder: NSObjectProtocol {
    func decode(certificateData: Data) throws -> Certificate
}
