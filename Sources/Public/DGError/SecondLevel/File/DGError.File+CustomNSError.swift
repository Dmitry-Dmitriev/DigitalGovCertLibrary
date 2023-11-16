import Foundation

extension DGError.File: CustomNSError {
    /// error code of DGError.File error
    public var errorCode: Int {
        dgError.errorCode
    }
}
