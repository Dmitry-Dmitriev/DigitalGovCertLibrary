import Foundation

extension DGError.Network.Response: CustomNSError {
    /// error code of DGError.Network.Response error
    public var errorCode: Int {
        dgError.errorCode
    }
}
