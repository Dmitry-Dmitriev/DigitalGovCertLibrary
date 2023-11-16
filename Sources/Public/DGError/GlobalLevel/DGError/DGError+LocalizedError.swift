import Foundation

extension DGError: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case let .file(fileError):
            return fileError.errorDescription
        case let .network(networkError):
            return networkError.errorDescription
        case let .certificate(certificateError):
            return certificateError.errorDescription
        }
    }

    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .file(fileError):
            return fileError.failureReason
        case let .network(networkError):
            return networkError.failureReason
        case let .certificate(certificateError):
            return certificateError.failureReason
        }
    }

    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case let .file(fileError):
            return fileError.recoverySuggestion
        case let .network(networkError):
            return networkError.recoverySuggestion
        case let .certificate(certificateError):
            return certificateError.recoverySuggestion
        }
    }
}
