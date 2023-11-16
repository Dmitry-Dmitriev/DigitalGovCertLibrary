import Foundation

public extension DGError {
    enum Certificate: Error {
        case creation(data: Data)
        case validation(_ error: DGError.Certificate.Validation)
        case decoding(_ error: DGError.Certificate.Decoding)
    }
}
