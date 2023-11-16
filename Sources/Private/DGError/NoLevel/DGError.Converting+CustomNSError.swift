import Foundation

extension DGError.Converting: CustomNSError {
    var errorCode: Int {
        switch self {
        case .stringFromData: return 10
        case .dataFromBase64: return 11
        case .urlFromString: return 12
        }
    }
}
