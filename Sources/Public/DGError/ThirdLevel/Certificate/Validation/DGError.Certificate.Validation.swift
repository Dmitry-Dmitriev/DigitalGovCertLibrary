import Foundation

/// Certificate's validation  errors
public extension DGError.Certificate {
    enum Validation: Error {
        case error(_ error: Error)
        case status(_ status: OSStatus, secResult: SecTrustResultType)
    }
}
