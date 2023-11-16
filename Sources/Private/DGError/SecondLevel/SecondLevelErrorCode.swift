import Foundation

protocol SecondLevelErrorCode: LevelErrorCode {
    static var secondErrorCodeLevel: Int { get }
    var dgError: DGError { get }
}

extension SecondLevelErrorCode {
    static var secondErrorCodeLevel: Int {
        return Int(1e1)
    }
}
