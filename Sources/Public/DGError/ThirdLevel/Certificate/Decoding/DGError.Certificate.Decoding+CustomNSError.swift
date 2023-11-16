import Foundation

extension DGError.Certificate.Decoding: CustomNSError {
    /// error code of DGError.Certificate.Decoding error
    public var errorCode: Int {
        dgError.errorCode
    }
}
