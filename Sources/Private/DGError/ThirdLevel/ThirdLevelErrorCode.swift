import Foundation

protocol ThirdLevelErrorCode: LevelErrorCode {
    static var thirdErrorCodeLevel: Int { get }
    var dgError: DGError { get }
}

extension ThirdLevelErrorCode {
    static var thirdErrorCodeLevel: Int {
        return Int(1e0)
    }
}
