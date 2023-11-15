
import Foundation

extension DGError.Network.Response: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .unexpected(type):
            localizedMessage(key: .dgerrorNetworkResponseCode221DescriptionKey, args: [type])
        case let .error(error):
            localizedMessage(key: .dgerrorNetworkResponseCode222DescriptionKey, args: [String(error)])
        }
    }
    public var failureReason: String? {
        switch self {
        case .unexpected:
            localizedMessage(key: .dgerrorNetworkResponseCode221FailureReasonKey)
        case let .error(error):
            localizedMessage(key: .dgerrorNetworkResponseCode222FailureReasonKey, args: [String(error)])
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case let .unexpected(type):
            localizedMessage(key: .dgerrorNetworkResponseCode221RecoverySuggestionKey, args: [type])
        case let .error(error):
            localizedMessage(key: .dgerrorNetworkResponseCode222RecoverySuggestionKey, args: [String(error)])   
        }
    }
}

private extension String {
    static let dgerrorNetworkResponseCode221DescriptionKey = "dgerror.network.response.code.221.description"
    static let dgerrorNetworkResponseCode221FailureReasonKey = "dgerror.network.response.code.221.failureReason"
    static let dgerrorNetworkResponseCode221RecoverySuggestionKey = "dgerror.network.response.code.221.recoverySuggestion"
    
    static let dgerrorNetworkResponseCode222DescriptionKey = "dgerror.network.response.code.222.description"
    static let dgerrorNetworkResponseCode222FailureReasonKey = "dgerror.network.response.code.222.failureReason"
    static let dgerrorNetworkResponseCode222RecoverySuggestionKey = "dgerror.network.response.code.222.recoverySuggestion"
}
