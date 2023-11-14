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
        case unexpected(type: String)
    }
}

extension DGError.File: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .reading: return 1 * secondErrorCodeLevel // 110
        case .missing: return 2 * secondErrorCodeLevel // 120
        case .decoding: return 3 * secondErrorCodeLevel // 130
        }
    }
}

extension DGError.Network: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .request: return 1 * secondErrorCodeLevel // 210
        case let .response(error): return 2 * secondErrorCodeLevel + error.errorCode // 220 + error.errorCode
        }
    }
}
extension DGError.Network.Response: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .unexpected: return 1 * thirdErrorCodeLevel // 221
        }
    }
}
extension DGError.Converting: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .stringFromData: return 1 * secondErrorCodeLevel // 310
        case .dataFromBase64: return 2 * secondErrorCodeLevel // 320
        case .urlFromString: return 3 * secondErrorCodeLevel // 330
        }
    }
}
extension DGError.Certificate: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .creation: return 1 * secondErrorCodeLevel // 410
        case let .validation(error): return 2 * secondErrorCodeLevel + error.errorCode // 420 + error.errorCode
        }
    }
}
extension DGError.Certificate.Validation: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .error: return 1 * thirdErrorCodeLevel // 421
        case .status: return 2 * thirdErrorCodeLevel // 422
        }
    }
}

extension DGError: GlobalLevelErrorCode {}

extension DGError.File: SecondLevelErrorCode {
    var upGlobal: DGError {
        DGError.file(self)
    }
}
extension DGError.Network: SecondLevelErrorCode {
    var upGlobal: DGError {
        DGError.network(self)
    }
}
extension DGError.Converting: SecondLevelErrorCode {
    var upGlobal: DGError {
        DGError.converting(self)
    }
}
extension DGError.Certificate: SecondLevelErrorCode {
    var upGlobal: DGError {
        DGError.certificate(self)
    }
}

extension DGError.Network.Response: ThirdLevelErrorCode {
    var upSecond: SecondLevelErrorCode {
        return DGError.Network.response(error: self)
    }
}
extension DGError.Certificate.Validation: ThirdLevelErrorCode {
    var upSecond: SecondLevelErrorCode {
        return DGError.Certificate.validation(self)
    }
}

protocol GlobalLevelErrorCode {
    var globalErrorCodeLevel: Int { get }
}

extension GlobalLevelErrorCode {
    var globalErrorCodeLevel: Int {
        return Int(1e2)
    }
}

protocol SecondLevelErrorCode {
    var secondErrorCodeLevel: Int { get }
    var upGlobal: DGError { get }
}

extension SecondLevelErrorCode {
    var secondErrorCodeLevel: Int {
        return Int(1e1)
    }
}

protocol ThirdLevelErrorCode {
    var thirdErrorCodeLevel: Int { get }
    var upSecond: SecondLevelErrorCode { get }
}

extension ThirdLevelErrorCode {
    var thirdErrorCodeLevel: Int {
        return Int(1e0)
    }
}
