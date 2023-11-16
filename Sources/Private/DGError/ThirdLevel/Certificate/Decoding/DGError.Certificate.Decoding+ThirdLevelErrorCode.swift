import Foundation

extension DGError.Certificate.Decoding: ThirdLevelErrorCode {
    var levelErrorCode: Int {
        switch self {
        case .pem:
            return 1 * Self.thirdErrorCodeLevel // errorCode 331
        case .der:
            return 2 * Self.thirdErrorCodeLevel // errorCode 332
        case .universal:
            return 3 * Self.thirdErrorCodeLevel // errorCode 333
        }
    }

    var dgError: DGError {
        return DGError.Certificate.decoding(self).dgError
    }
}
