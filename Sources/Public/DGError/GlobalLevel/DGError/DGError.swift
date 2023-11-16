import Foundation

/// Library errors
public enum DGError: Error {
    case file(_ error: DGError.File)
    case network(_ error: DGError.Network)
    case certificate(_ error: DGError.Certificate)
}
