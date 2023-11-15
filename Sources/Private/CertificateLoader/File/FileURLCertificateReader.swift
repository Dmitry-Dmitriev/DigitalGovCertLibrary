import Foundation

final class FileURLCertificateReader: CertificateReader {
    private let url: URL
    private let certDecoder: UniversalDecoder

    init(url: URL, certDecoder: UniversalDecoder = UniversalCertDecoder()) {
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

extension URL {
    var fileName: String {
        return lastPathComponent
    }
    
    var filePath: String {
        return deletingLastPathComponent().absoluteString
    }
}
