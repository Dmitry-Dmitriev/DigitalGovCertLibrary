

import Foundation

@objc public final class UniversalCertDecoder: NSObject, UniversalDecoder {
    private let derDecoder: DerDecoder = DerFormatCertDecoder()
    private let pemDecoder: PemDecoder = PemFormatCertDecoder()

    @objc public func decode(certificateData: Data) throws -> Certificate {
        if let pemFile = try? pemDecoder.decode(pemData: certificateData) {
            return pemFile
        }
        if let derFile = try? derDecoder.decode(derData: certificateData) {
            return derFile
        }

        throw DGError.certDecoding(name: .empty, atPath: .empty)
    }
}
