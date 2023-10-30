

import Foundation

/// no docs
@objc public final class Certificate: NSObject {
    /// no docs
    @objc public let certificate: SecCertificate

    internal init(certificate: SecCertificate) {
        self.certificate = certificate
    }
}

extension Certificate: Decodable {
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        try self.init(data: data)
    }
}
