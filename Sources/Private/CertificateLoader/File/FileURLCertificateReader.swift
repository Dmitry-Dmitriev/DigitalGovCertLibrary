import Foundation

final class FileURLCertificateReader: CertificateReader {
    private let url: URL
    private let certDecoder: CertificateDecoder

    init(url: URL, certDecoder: CertificateDecoder = UniversalCertDecoder()) {
        self.url = url
        self.certDecoder = certDecoder
    }

    func readCertificate() throws -> Certificate {
        do {
            let data = try Data(contentsOf: url)
            let cert = try certDecoder.decode(certificateData: data)
            return cert
        } catch {
            throw DGError.File.decoding(name: url.fileName,
                                        atPath: url.filePath,
                                        reason: error.localizedDescription).dgError

        }
    }
}
