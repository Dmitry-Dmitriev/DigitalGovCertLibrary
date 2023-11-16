import Foundation

extension DGError.Network: SecondLevelErrorCode {
    var levelErrorCode: Int {
        switch self {
        case .request: return 1 * Self.secondErrorCodeLevel // errorCode 210
        case let .response(error): return 2 * Self.secondErrorCodeLevel + error.levelErrorCode // errorCode 220 + error.levelErrorCode
        }
    }

    var dgError: DGError {
        DGError.network(self)
    }
}
