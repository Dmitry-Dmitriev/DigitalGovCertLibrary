import Foundation

protocol UniversalDecoder {
    func decode(certificateData: Data) throws -> Certificate
}

extension UniversalDecoder where Self: PemDecoder, Self: DerDecoder {
    func decode(certificateData: Data) throws -> Certificate {
        let pemResult = Result(autoCatching: try decode(pemData: certificateData))
        if let pemFile = try? pemResult.get() {
            return pemFile
        }
        
        let derResult = Result(autoCatching: try decode(derData: certificateData))
        if let derFile = try? derResult.get() {
            return derFile
        }
        let results  = [pemResult, derResult]
        throw DGError.Certificate.Decoding.universal(results).dgError
    }
}

extension Result where Failure == Error {
    init(autoCatching: @autoclosure () throws -> Success) {
        self.init(catching: autoCatching)
    }
}
