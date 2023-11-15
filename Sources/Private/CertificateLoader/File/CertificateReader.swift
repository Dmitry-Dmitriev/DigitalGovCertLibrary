import Foundation

protocol CertificateReader {
    func readCertificate() throws -> Certificate
}

extension CertificateReader {
    func readCertificateResult() -> Result<Certificate, Error> {
        return Result(autoCatching: try readCertificate())
    }
}
