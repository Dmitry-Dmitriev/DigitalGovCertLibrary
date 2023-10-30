
import Foundation

public enum DGError: Error {
    case missingFile(name: String, atPath: String)
    case certDecoding(name: String, atPath: String)
    case certReading(name: String, atPath: String, reason: String)
}

extension DGError {
    enum File: Error {
        case reading
        case missing
    }
    
    enum Network: Error {
        case request(_ req: URLRequest, error: Error)
    }

    enum Converting {
        case stringFromData(_ data: Data)
        case dataFromBase64(_ string: String)
        case urlFromString(_ string: String)
    }
    
    enum Certificate: Error {
        case creation(data: Data)
        case validationError(_ error: Error)
        case validationStatus(_ status: OSStatus)
    }
}

extension DGError.Certificate {
    enum Validation: Error {
        case error(_ error: Error)
        case status(_ status: OSStatus)
    }
}
extension DGError.Certificate {
    enum Format: Error {
        case unsupported
    }
}

extension DGError.Network {
    enum Response: Error {
        case unexpected
    }
}

func test() {
    let aaa = "test1" == "test" ? DGError.Certificate.creation(data: .init()): DGError.Certificate.validationStatus(errSecSuccess)
    switch aaa {
    case let .validationError(error): print(error.localizedDescription)
         print("")
    default:
        break
    }
}
