
import Foundation

public enum DGError: Error {
    case file(_ error: DGError.File)
    case network(_ error: DGError.Network)
    case converting(_ error: DGError.Converting)
    case certificate(_ error: DGError.Certificate)
}

public extension DGError {
    enum File: Error {
        case reading(name: String, atPath: String, reason: String)
        case missing(name: String, atPath: String)
        case decoding(name: String, atPath: String, reason: String)
    }

    enum Network: Error {
        case request(_ req: WebRequestProvider, error: Error)
        case response(error: DGError.Network.Response)
    }

    enum Converting {
        case stringFromData(_ data: Data)
        case dataFromBase64(_ string: String)
        case urlFromString(_ string: String)
    }
    
    enum Certificate: Error {
        case creation(data: Data)
        case validation(_ error: DGError.Certificate.Validation)
    }
}

public extension DGError.Certificate {
    enum Validation: Error {
        case error(_ error: Error)
        case status(_ status: OSStatus, secResult: SecTrustResultType)
    }
}

public extension DGError.Network {
    enum Response: Error {
        case unexpected
    }
}

extension DGError.File: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .reading: return 1 * multiplier
        case .missing: return 2 * multiplier
        case .decoding: return 3 * multiplier
        }
    }
}

extension DGError.Network: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .request: return 1 * multiplier
        case let .response(error): return 2 * multiplier + error.errorCode
        }
    }
}
extension DGError.Network.Response: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .unexpected: return 1 * multiplier
        }
    }
}
extension DGError.Converting: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .stringFromData: return 1 * multiplier
        case .dataFromBase64: return 2 * multiplier
        case .urlFromString: return 3 * multiplier
        }
    }
}
extension DGError.Certificate: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .creation: return 1 * multiplier
        case let .validation(error): return 2 * multiplier + error.errorCode
        }
    }
}
extension DGError.Certificate.Validation: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .error: return 1 * multiplier
        case .status: return 2 * multiplier
        }
    }
}

extension DGError: GlobalLevelErrorCode {}

extension DGError.File: SecondLevelErrorCode {}
extension DGError.Network: SecondLevelErrorCode {}
extension DGError.Converting: SecondLevelErrorCode {}
extension DGError.Certificate: SecondLevelErrorCode {}

extension DGError.Network.Response: ThirdLevelErrorCode {}
extension DGError.Certificate.Validation: ThirdLevelErrorCode {}


protocol GlobalLevelErrorCode {
    var multiplier: Int { get }
}

extension GlobalLevelErrorCode {
    var multiplier: Int {
        return Int(1e3)
    }
}

protocol SecondLevelErrorCode {
    var multiplier: Int { get }
}

extension SecondLevelErrorCode {
    var multiplier: Int {
        return Int(1e2)
    }
}

protocol ThirdLevelErrorCode {
    var multiplier: Int { get }
}

extension ThirdLevelErrorCode {
    var multiplier: Int {
        return Int(1e1)
    }
}
