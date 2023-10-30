
import Foundation

extension Certificate {
    convenience init(data: Data) throws {
        guard let certificate = SecCertificateCreateWithData(nil, data as CFData) else {
            throw DGError.Certificate.creation(data: data)
        }

        self.init(certificate: certificate)
    }
}
