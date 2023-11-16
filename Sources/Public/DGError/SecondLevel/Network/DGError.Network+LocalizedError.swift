import Foundation

extension DGError.Network: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case let .request(requestProvider, error: _):
            if let request = try? requestProvider.request {
                return localizedMessage(key: .dgerrorCode210DescriptionOption1Key, args: [String(request)])
            } else {
                return localizedMessage(key: .dgerrorCode210DescriptionOption2Key, args: [String(requestProvider)])
            }
        case let .response(error):
            return error.errorDescription
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .request(_, error: error):
            return localizedMessage(key: .dgerrorCode210FailureReasonKey, args: [String(error)])
        case let .response(error):
            return error.failureReason
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case let .request(_, error: error):
            return localizedMessage(key: .dgerrorCode210RecoverySuggestionKey, args: [String(error)])
        case let .response(error):
            return error.recoverySuggestion
        }
    }
}

private extension String {
    static let dgerrorCode210DescriptionOption1Key = "dgerror.network.request.code.210.description.option1"
    static let dgerrorCode210DescriptionOption2Key = "dgerror.network.request.code.210.description.option2"
    static let dgerrorCode210FailureReasonKey = "dgerror.network.request.code.210.failureReason"
    static let dgerrorCode210RecoverySuggestionKey = "dgerror.network.request.code.210.recoverySuggestion"
}
