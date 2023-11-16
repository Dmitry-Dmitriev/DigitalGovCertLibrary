import Foundation

extension DGError.Network.Response: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case let .unexpected(type):
            localizedMessage(key: .dgerrorCode221DescriptionKey, args: [type])
        case let .error(error):
            localizedMessage(key: .dgerror222DescriptionKey, args: [String(error)])
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case .unexpected:
            localizedMessage(key: .dgerrorCode221FailureReasonKey)
        case let .error(error):
            localizedMessage(key: .dgerrorCode222FailureReasonKey, args: [String(error)])
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case let .unexpected(type):
            localizedMessage(key: .dgerrorCode221RecoverySuggestionKey, args: [type])
        case let .error(error):
            localizedMessage(key: .dgerrorCode222RecoverySuggestionKey, args: [String(error)])
        }
    }
}

private extension String {
    static let dgerrorCode221DescriptionKey = "dgerror.network.response.code.221.description"
    static let dgerrorCode221FailureReasonKey = "dgerror.network.response.code.221.failureReason"
    static let dgerrorCode221RecoverySuggestionKey = "dgerror.network.response.code.221.recoverySuggestion"

    static let dgerror222DescriptionKey = "dgerror.network.response.code.222.description"
    static let dgerrorCode222FailureReasonKey = "dgerror.network.response.code.222.failureReason"
    static let dgerrorCode222RecoverySuggestionKey = "dgerror.network.response.code.222.recoverySuggestion"
}
