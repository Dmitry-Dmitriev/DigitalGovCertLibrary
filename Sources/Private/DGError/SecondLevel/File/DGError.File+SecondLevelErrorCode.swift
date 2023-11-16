import Foundation

extension DGError.File: SecondLevelErrorCode {
    var levelErrorCode: Int {
        switch self {
        case .reading: return 1 * Self.secondErrorCodeLevel // errorCode 110
        case .missing: return 2 * Self.secondErrorCodeLevel // errorCode 120
        case .decoding: return 3 * Self.secondErrorCodeLevel // errorCode 130
        }
    }

    var dgError: DGError {
        DGError.file(self)
    }
}
