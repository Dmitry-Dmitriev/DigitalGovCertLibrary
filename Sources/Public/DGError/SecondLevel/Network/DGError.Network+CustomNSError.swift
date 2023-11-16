import Foundation

extension DGError.Network: CustomNSError {
    /// error code of DGError.Network error
    public var errorCode: Int {
        dgError.errorCode
    }
}
