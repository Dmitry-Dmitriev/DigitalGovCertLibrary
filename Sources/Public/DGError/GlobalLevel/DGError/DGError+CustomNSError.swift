import Foundation

extension DGError: CustomNSError {
    /// error code of DGError
    public var errorCode: Int {
        switch self {
        case let .file(error):
            return levelErrorCode + error.levelErrorCode
        case let .network(error):
            return levelErrorCode + error.levelErrorCode
        case let .certificate(error):
            return levelErrorCode + error.levelErrorCode
        }
    }
}
