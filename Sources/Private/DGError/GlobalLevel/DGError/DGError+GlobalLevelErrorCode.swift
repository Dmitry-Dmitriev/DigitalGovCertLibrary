import Foundation

extension DGError: GlobalLevelErrorCode {
    var levelErrorCode: Int {
        switch self {
        case .file:
            return 1 * Self.globalErrorCodeLevel
        case .network:
            return 2 * Self.globalErrorCodeLevel
        case .certificate:
            return 3 * Self.globalErrorCodeLevel
        }
    }
}
