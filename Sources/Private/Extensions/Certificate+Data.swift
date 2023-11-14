import Foundation

extension Certificate {
    convenience init(data: Data) throws {
        guard let certificate = SecCertificateCreateWithData(nil, data as CFData) else {
            // fixme
            throw DGError.Certificate.creation(data: data).upGlobal
        }

        self.init(certificate: certificate)
    }
}
