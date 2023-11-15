import Foundation

protocol DerDecoder {
    func decode(derData: Data) throws -> Certificate
}

extension DerDecoder {
    func decode(derData: Data) throws -> Certificate {
        do {
            return try Certificate(data: derData)
        } catch {
            throw DGError.Certificate.Decoding.der(error).dgError
        }
    }
}
