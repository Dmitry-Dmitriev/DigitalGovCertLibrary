import Foundation

extension DGError.Certificate.Validation: CustomNSError {
    /// error code of DGError.Certificate.Validation error
    public var errorCode: Int {
        dgError.errorCode
    }
}
