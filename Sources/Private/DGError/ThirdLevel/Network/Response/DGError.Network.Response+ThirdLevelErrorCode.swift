import Foundation

extension DGError.Network.Response: ThirdLevelErrorCode {
    var levelErrorCode: Int {
        switch self {
        case .unexpected: return 1 * Self.thirdErrorCodeLevel // 221
        case .error: return 2 * Self.thirdErrorCodeLevel // 222
        }
    }

    var dgError: DGError {
        return DGError.Network.response(error: self).dgError
    }
}
