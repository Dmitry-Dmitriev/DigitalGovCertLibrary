import Foundation

@objc public final class UniversalCertDecoder: NSObject, UniversalDecoder {
    private let derDecoder: DerDecoder = DerFormatCertDecoder()
    private let pemDecoder: PemDecoder = PemFormatCertDecoder()

    public override init() {
        super.init()
    }

    @objc public func decode(certificateData: Data) throws -> Certificate {
        let pemResult = Result(autoCatching: try pemDecoder.decode(pemData: certificateData))
        if let pemFile = try? pemResult.get() {
            return pemFile
        }
        
        let derResult = Result(autoCatching: try derDecoder.decode(derData: certificateData))
        if let derFile = try? derResult.get() {
            return derFile
        }
        let results  = [pemResult, derResult]
        throw DGError.Certificate.Decoding.universal(results).dgError
    }
}
