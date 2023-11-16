import Foundation

extension DGError.File: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case let .reading(name: name, atPath: path, reason: _):
            return localizedMessage(key: .dgerrorCode110DescriptionKey,
                                    args: [name, path])
        case  let .missing(name: name, atPath: path):
            return localizedMessage(key: .dgerrorCode120DescriptionKey,
                                    args: [name, path])
        case let .decoding(name: name, atPath: path, reason: _):
            return localizedMessage(key: .dgerrorCode130DescriptionKey,
                                    args: [name, path])
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .reading(name: _, atPath: _, reason: reason):
            return localizedMessage(key: .dgerrorCode110FailureReasonKey,
                                    args: [reason])
        case let .missing(name: name, atPath: path):
            return localizedMessage(key: .dgerrorCode120FailureReasonKey,
                                    args: [name, path])
        case let .decoding(name: name, atPath: path, reason: reason):
            return localizedMessage(key: .dgerrorCode130FailureReasonKey,
                                    args: [name, path, reason])
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case .reading:
            return localizedMessage(key: .dgerrorCode110RecoverySuggestionKey)
        case  let .missing(name: name, atPath: path):
            return localizedMessage(key: .dgerrorCode120RecoverySuggestionKey,
                                    args: [name, path])
        case .decoding:
            let crtsList = CertExtension.list.map { .singleQuote + $0 + .singleQuote }.joined(separator: .comma)
            return localizedMessage(key: .dgerrorCode130RecoverySuggestionKey,
                                    args: [crtsList])
        }
    }
}

private extension String {
    static let dgerrorCode110DescriptionKey = "dgerror.file.reading.code.110.description"
    static let dgerrorCode110FailureReasonKey = "dgerror.file.reading.code.110.failureReason"
    static let dgerrorCode110RecoverySuggestionKey = "dgerror.file.reading.code.110.recoverySuggestion"

    static let dgerrorCode120DescriptionKey = "dgerror.file.missing.code.120.description"
    static let dgerrorCode120FailureReasonKey = "dgerror.file.missing.code.120.failureReason"
    static let dgerrorCode120RecoverySuggestionKey = "dgerror.file.missing.code.120.recoverySuggestion"

    static let dgerrorCode130DescriptionKey = "dgerror.file.decoding.code.130.description"
    static let dgerrorCode130FailureReasonKey = "dgerror.file.decoding.code.130.failureReason"
    static let dgerrorCode130RecoverySuggestionKey = "dgerror.file.decoding.code.130.recoverySuggestion"
}
