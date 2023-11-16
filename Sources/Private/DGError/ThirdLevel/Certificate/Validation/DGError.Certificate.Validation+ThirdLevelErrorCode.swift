import Foundation

extension DGError.Certificate.Validation: ThirdLevelErrorCode {
    var levelErrorCode: Int {
        switch self {
        case .error: return 1 * Self.thirdErrorCodeLevel  // errorCode 321
        case .status: return 2 * Self.thirdErrorCodeLevel // errorCode 322
        }
    }

    var dgError: DGError {
        return DGError.Certificate.validation(self).dgError
    }
}
