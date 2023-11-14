import Foundation

protocol DerDecoder {
    func decode(derData: Data) throws -> Certificate
}

extension DerDecoder {
    func decode(derData: Data) throws -> Certificate {
        return try Certificate(data: derData)
    }
}
