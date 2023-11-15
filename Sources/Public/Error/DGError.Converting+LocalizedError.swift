
import Foundation

extension DGError.Converting: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .stringFromData:
            return localizedMessage(key: .dgerrorConvertionUrlFromStrCode10DescriptionKey)
        case .dataFromBase64:
            return localizedMessage(key: .dgerrorConvertionDataFromBase64Code11DescriptionKey)
        case .urlFromString:
            return localizedMessage(key: .dgerrorConvertionUrlFromStrCode12DescriptionKey)
        }
    }

    public var failureReason: String? {
        switch self {
        case let .stringFromData(data):
            return localizedMessage(key: .dgerrorConvertionUrlFromStrCode10FailureReasonKey, args: [String(data)])
        case let .dataFromBase64(string):
            return localizedMessage(key: .dgerrorConvertionDataFromBase64Code11FailureReasonKey, args: [string])
        case let .urlFromString(string):
            return localizedMessage(key: .dgerrorConvertionUrlFromStrCode12FailureReasonKey, args: [string])
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .stringFromData:
            return localizedMessage(key: .dgerrorConvertionUrlFromStrCode10RecoverySuggestionKey)
        case .dataFromBase64:
            return localizedMessage(key: .dgerrorConvertionDataFromBase64Code11RecoverySuggestionKey)
        case .urlFromString:
            return localizedMessage(key: .dgerrorConvertionUrlFromStrCode12RecoverySuggestionKey)
        }
    }
}

private extension String {
    static let dgerrorConvertionUrlFromStrCode10DescriptionKey = "dgerror.convering.code.10.description"
    static let dgerrorConvertionUrlFromStrCode10FailureReasonKey = "dgerror.convering.code.10.failureReason"
    static let dgerrorConvertionUrlFromStrCode10RecoverySuggestionKey = "dgerror.convering.code.10.recoverySuggestion"

    static let dgerrorConvertionDataFromBase64Code11DescriptionKey = "dgerror.converting.code.11.description"
    static let dgerrorConvertionDataFromBase64Code11FailureReasonKey = "dgerror.converting.code.11.failureReason"
    static let dgerrorConvertionDataFromBase64Code11RecoverySuggestionKey = "dgerror.converting.code.11.recoverySuggestion"

    static let dgerrorConvertionUrlFromStrCode12DescriptionKey = "dgerror.converting.code.12.description"
    static let dgerrorConvertionUrlFromStrCode12FailureReasonKey = "dgerror.converting.code.12.failureReason"
    static let dgerrorConvertionUrlFromStrCode12RecoverySuggestionKey = "dgerror.converting.code.12.recoverySuggestion"
}
