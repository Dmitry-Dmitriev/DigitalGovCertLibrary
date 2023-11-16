import Foundation

/// Any object that can `transform` data to Certificate objectt
public protocol CertificateDecoder: NSObjectProtocol {
    func decode(certificateData: Data) throws -> Certificate
}

extension CertificateDecoder where Self: PemDecoder, Self: DerDecoder {
    func decode(certificateData: Data) throws -> Certificate {
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
