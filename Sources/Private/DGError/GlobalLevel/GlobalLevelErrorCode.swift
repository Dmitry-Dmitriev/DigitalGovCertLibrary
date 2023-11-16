import Foundation

protocol GlobalLevelErrorCode: LevelErrorCode {
    static var globalErrorCodeLevel: Int { get }
}

extension GlobalLevelErrorCode {
    static var globalErrorCodeLevel: Int {
        return Int(1e2)
    }
}
