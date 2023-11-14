import Foundation

protocol CertificateReader {
    func readCertificate() throws -> Certificate
}

extension CertificateReader {
    func readCertificateResult() -> Result<Certificate, Error> {
        do {
            let cert = try readCertificate()
            return .success(cert)
        } catch {
            return .failure(error)
        }
    }
}
