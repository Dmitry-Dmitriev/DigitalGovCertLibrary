

import Foundation

extension DGError.Certificate: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .creation:
            return "It is not possible to create SecCertificate from data."
        case let .validation(error):
            return error.errorDescription
        }
    }
    public var failureReason: String? {
        switch self {
        case let .creation(data: data):
            return "Data \(data) could not be converted to SecCertificate."
        case let .validation(error):
            return error.failureReason
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .creation:
            return "Try to use another data."
        case let .validation(error):
            return error.recoverySuggestion
        }
    }
}
