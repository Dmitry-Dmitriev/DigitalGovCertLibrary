import Foundation

extension DGError.Certificate: SecondLevelErrorCode {
    var levelErrorCode: Int {
        switch self {
        case .creation: return 1 * Self.secondErrorCodeLevel // errorCode 310
        case let .validation(error): return 2 * Self.secondErrorCodeLevel + error.levelErrorCode // errorCode 320 + error.levelErrorCode
        case let .decoding(error): return 3 * Self.secondErrorCodeLevel + error.levelErrorCode // errorCode 330 + error.levelErrorCode
        }
    }

    var dgError: DGError {
        DGError.certificate(self)
    }
}
