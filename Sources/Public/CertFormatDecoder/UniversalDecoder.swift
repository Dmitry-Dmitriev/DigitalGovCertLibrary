
import Foundation

protocol UniversalDecoder {
    func decode(certificateData: Data) throws -> Certificate
}

extension UniversalDecoder where Self: PemDecoder, Self: DerDecoder {
    func decode(certificateData: Data) throws -> Certificate {
        if let pemFile = try? decode(pemData: certificateData) {
            return pemFile
        }
        if let derFile = try? decode(derData: certificateData) {
            return derFile
        }

        throw DGError.Certificate.creation(data: certificateData)
    }
}
