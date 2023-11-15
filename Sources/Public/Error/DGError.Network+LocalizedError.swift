
import Foundation

extension DGError.Network: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .request(requestProvider, error: _):
            if let request = try? requestProvider.request {
                return localizedMessage(key: .dgerrorNetworkRequestCode210DescriptionOption1Key, args: [String(request)])
            } else {
                return localizedMessage(key: .dgerrorNetworkRequestCode210DescriptionOption2Key, args: [String(requestProvider)])
            }
        case let .response(error):
            return error.errorDescription
        }
    }
    public var failureReason: String? {
        switch self {
        case let .request(_, error: error):
            return localizedMessage(key: .dgerrorNetworkRequestCode210FailureReasonKey, args: [String(error)])
        case let .response(error):
            return error.failureReason
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case let .request(_, error: error):
            return localizedMessage(key: .dgerrorNetworkRequestCode210RecoverySuggestionKey, args: [String(error)])
        case let .response(error):
            return error.recoverySuggestion
        }
    }
}

private extension String {
    static let dgerrorNetworkRequestCode210DescriptionOption1Key = "dgerror.network.request.code.210.description.option1"
    static let dgerrorNetworkRequestCode210DescriptionOption2Key = "dgerror.network.request.code.210.description.option2"
    static let dgerrorNetworkRequestCode210FailureReasonKey = "dgerror.network.request.code.210.failureReason"
    static let dgerrorNetworkRequestCode210RecoverySuggestionKey = "dgerror.network.request.code.210.recoverySuggestion"
}
