import Foundation

final class FileURLCertificateReader: CertificateReader {
    private let url: URL
    private let certDecoder: UniversalDecoder
    
    init(url: URL, certDecoder: UniversalDecoder = UniversalCertDecoder()) {
        self.url = url
        self.certDecoder = certDecoder
    }

    func readCertificate() throws -> Certificate {
        let data = try Data(contentsOf: url)
        let cert = try certDecoder.decode(certificateData: data)
        return cert
    }
}
