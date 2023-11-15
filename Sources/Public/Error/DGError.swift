import Foundation

public enum DGError: Error {
    case file(_ error: DGError.File)
    case network(_ error: DGError.Network)
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

    enum Certificate: Error {
        case creation(data: Data)
        case decoding(_ error: DGError.Certificate.Decoding)
        case validation(_ error: DGError.Certificate.Validation)
    }
}

public extension DGError.Certificate {
    enum Validation: Error {
        case error(_ error: Error)
        case status(_ status: OSStatus, secResult: SecTrustResultType)
    }
}

public extension DGError.Certificate {
    enum Decoding: Error {
        case pem(_ error: Error)
        case der(_ error: Error)
        case universal(_ results: [Result<Certificate, Error>])
    }
}


public extension DGError.Network {
    enum Response: Error {
        case unexpected(type: String)
        case error(_ error: Error)
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
        case .error: return 2 * thirdErrorCodeLevel // 222
        }
    }
}

extension DGError {
    enum Converting {
        case stringFromData(_ data: Data)
        case dataFromBase64(_ string: String)
        case urlFromString(_ string: String)
    }
}

extension DGError.Converting: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .stringFromData: return 10
        case .dataFromBase64: return 11
        case .urlFromString: return 12
        }
    }
}

extension DGError.Certificate: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .creation: return 1 * secondErrorCodeLevel // 310
        case let .validation(error): return 2 * secondErrorCodeLevel + error.errorCode // 320 + error.errorCode
        case let .decoding(error): return 3 * secondErrorCodeLevel + error.errorCode // 330 + error.errorCode
        }
    }
}

extension DGError.Certificate.Validation: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .error: return 1 * thirdErrorCodeLevel // 321
        case .status: return 2 * thirdErrorCodeLevel // 322
        }
    }
}

extension DGError.Certificate.Decoding: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .pem:
            return 1 * thirdErrorCodeLevel // 331
        case .der:
            return 2 * thirdErrorCodeLevel // 332
        case .universal:
            return 3 * thirdErrorCodeLevel // 333
        }
    }
}

extension DGError: GlobalLevelErrorCode {}

extension DGError.File: SecondLevelErrorCode {
    var dgError: DGError {
        DGError.file(self)
    }
}
extension DGError.Network: SecondLevelErrorCode {
    var dgError: DGError {
        DGError.network(self)
    }
}

extension DGError.Certificate: SecondLevelErrorCode {
    var dgError: DGError {
        DGError.certificate(self)
    }
}


extension DGError.Network.Response: ThirdLevelErrorCode {
    var dgError: DGError {
        return DGError.Network.response(error: self).dgError
    }
}


extension DGError.Certificate.Decoding: ThirdLevelErrorCode {
    var dgError: DGError {
        return DGError.Certificate.decoding(self).dgError
    }
}


extension DGError.Certificate.Validation: ThirdLevelErrorCode {
    var dgError: DGError {
        return DGError.Certificate.validation(self).dgError
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
    var dgError: DGError { get }
}

extension SecondLevelErrorCode {
    var secondErrorCodeLevel: Int {
        return Int(1e1)
    }
}

protocol ThirdLevelErrorCode {
    var thirdErrorCodeLevel: Int { get }
    var dgError: DGError { get }
}

extension ThirdLevelErrorCode {
    var thirdErrorCodeLevel: Int {
        return Int(1e0)
    }
}
