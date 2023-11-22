import Foundation

/// Certificate's decoding's errors
public extension DGError.Certificate {
    enum Decoding: Error {
        case pem(_ error: Error)
        case der(_ error: Error)
        case universal(_ results: [Result<Certificate, Error>])
    }
}
