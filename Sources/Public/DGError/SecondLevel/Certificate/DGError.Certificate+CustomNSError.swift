import Foundation

extension DGError.Certificate: CustomNSError {
    /// error code of DGError.Certificate error
    public var errorCode: Int {
        dgError.errorCode
    }
}
