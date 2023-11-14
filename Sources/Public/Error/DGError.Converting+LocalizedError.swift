
import Foundation

extension DGError.Converting: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .stringFromData:
            return "It is not possible to create string from data."
        case .dataFromBase64:
            return "It is not possible to create data from base64 string."
        case .urlFromString:
            return "It is not possible to create url from string."
        }

    }
    public var failureReason: String? {
        switch self {
        case let .stringFromData(data):
            return "Data \(data) could not be convrted to utf8 string."
        case let .dataFromBase64(string):
            return "Base64 string \(string) could not be converted to data."
        case let .urlFromString(string):
            return "String \(string)could not be converted to URL"
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case .stringFromData:
            return "Try to use another data."
        case .dataFromBase64:
            return "Try to use another base64 string."
        case .urlFromString:
            return "Try to use another string."
        }
    }
}
