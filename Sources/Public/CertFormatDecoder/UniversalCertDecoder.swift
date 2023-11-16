import Foundation

/// Universal object that unions different ways of decoding Certificate
@objc public final class UniversalCertDecoder: NSObject, CertificateDecoder {
    private let derDecoder: DerDecoder = DerFormatCertDecoder()
    private let pemDecoder: PemDecoder = PemFormatCertDecoder()

    /// Default initializer
    public override init() {
        super.init()
    }

//    @objc public func decode(certificateData: Data) throws -> Certificate {
//        let pemResult = Result(autoCatching: try pemDecoder.decode(pemData: certificateData))
//        if let pemFile = try? pemResult.get() {
//            return pemFile
//        }
//
//        let derResult = Result(autoCatching: try derDecoder.decode(derData: certificateData))
//        if let derFile = try? derResult.get() {
//            return derFile
//        }
//        let results = [pemResult, derResult]
//        throw DGError.Certificate.Decoding.universal(results).dgError
//    }

    /// Tries to create Certificate from raw data
    @objc public func decode(certificateData: Data) throws -> Certificate {
        let pemResult = Result(autoCatching: try decode(pemData: certificateData))
        if let pemFile = try? pemResult.get() {
            return pemFile
        }

        let derResult = Result(autoCatching: try decode(derData: certificateData))
        if let derFile = try? derResult.get() {
            return derFile
        }
        let results = [pemResult, derResult]
        throw DGError.Certificate.Decoding.universal(results).dgError
    }
}

extension UniversalCertDecoder: PemDecoder, DerDecoder {}
