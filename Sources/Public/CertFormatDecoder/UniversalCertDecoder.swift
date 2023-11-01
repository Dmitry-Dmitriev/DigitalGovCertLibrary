

import Foundation

@objc public final class UniversalCertDecoder: NSObject, UniversalDecoder {
    private let derDecoder: DerDecoder = DerFormatCertDecoder()
    private let pemDecoder: PemDecoder = PemFormatCertDecoder()

    public override init() {
        super.init()
    }

    @objc public func decode(certificateData: Data) throws -> Certificate {
        if let pemFile = try? pemDecoder.decode(pemData: certificateData) {
            return pemFile
        }
        if let derFile = try? derDecoder.decode(derData: certificateData) {
            return derFile
        }

        throw DGError.Certificate.creation(data: certificateData)
    }
}
