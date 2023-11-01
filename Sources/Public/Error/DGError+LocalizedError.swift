

import Foundation

// MARK: - LocalizedError
extension DGError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .file(fileError):
            return fileError.errorDescription
        case let .network(networkError):
            return networkError.errorDescription
        case let .converting(convertingError):
            return convertingError.errorDescription
        case let .certificate(certificateError):
            return certificateError.errorDescription
        }
    }

    public var failureReason: String? {
        switch self {
        case let .file(fileError):
            return fileError.failureReason
        case let .network(networkError):
            return networkError.failureReason
        case let .converting(convertingError):
            return convertingError.failureReason
        case let .certificate(certificateError):
            return certificateError.failureReason
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case let .file(fileError):
            return fileError.recoverySuggestion
        case let .network(networkError):
            return networkError.recoverySuggestion
        case let .converting(convertingError):
            return convertingError.recoverySuggestion
        case let .certificate(certificateError):
            return certificateError.recoverySuggestion
        }
    }
}

extension DGError.File: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .reading(name: name, atPath: path, reason: _):
            return "It is not possible to read the file \(name) at path \(path)."
        case  let .missing(name: name, atPath: path):
            return "The file \(name) is missing at path \(path)."
        case let .decoding(name: name, atPath: path, reason: _):
            return "It is not possible to read the file \(name) at path \(path)."
        }
    }

    public var failureReason: String? {
        switch self {
        case let .reading(name: _, atPath: _, reason: reason):
            return "Could not read the file because of the reason: \"\(reason)\"."
        case let .missing(name: name, atPath: path):
            return "The file \(name) is missing at path \(path)."
        case let .decoding(name: name, atPath: path, reason: reason):
            return "Certificate \(name) at path \(path) could not be decoded because of the reason: \(reason)."
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .reading:
            return "Please, try to open another file or correct the file extension."
        case  let .missing(name: name, atPath: path):
            return "The file \(name) could not be found at path \(path)."
        case .decoding:
            let crtsList = CertExtension.list.map { .singleQuote + $0 + .singleQuote }.joined(separator: .comma)
            let msgPart1 = "Please, try another file(s) with \(crtsList) extensions"
            let msgPart2 = " or original certificate file was not properly converted to desired extension."
            return msgPart1 + msgPart2
        }
    }
}


extension DGError.Network: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .request(requestProvider, error: _):
            if let request = try? requestProvider.request {
                return "Request \(request) fails."
            } else {
                return "Request fails."
            }
        }
    }
    public var failureReason: String? {
        switch self {
        case let .request(_, error: error):
            return "Reason: \"\(error)\"."
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case let .request(_, error: error):
            return "Try to fix the error: \"\(error)\"."
        }
    }
}

extension DGError.Network.Response: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unexpected:
            "Unexpected response type."
        }
    }
    public var failureReason: String? {
        switch self {
        case .unexpected:
            "Server does not send response body."
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case .unexpected:
            "Ask backend developer to send response body or choose another server endpoint."
        }
    }
}

extension DGError.Converting: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .stringFromData:
            return "It is not possible to create string from data."
        case .dataFromBase64:
            return "It is not possible to create data from base64 string."
        case .urlFromString:
            return "It is not possible to create url from string."
        }
        
    }
    public var failureReason: String? {
        switch self {
        case let .stringFromData(data):
            return "Data \(data) could not be convrted to utf8 string."
        case let .dataFromBase64(string):
            return "Base64 string \(string) could not be converted to data."
        case let .urlFromString(string):
            return "String \(string)could not be converted to URL"
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case .stringFromData:
            return "Try to use another data."
        case .dataFromBase64:
            return "Try to use another base64 string."
        case .urlFromString:
            return "Try to use another string."
        }
    }
}

extension DGError.Certificate: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .creation:
            return "It is not possible to create SecCertificate from data."
        }
    }
    public var failureReason: String? {
        switch self {
        case let .creation(data: data):
            return "Data \(data) could not be converted to SecCertificate."
        }
    }
    public var recoverySuggestion: String? {
        switch self {
        case .creation:
            return "Try to use another data."
        }
    }
}


//extension DGError.Certificate.Format: LocalizedError {
//    public var errorDescription: String? {
//        switch self {
//        case .unsupported:
//            return "It is not possible to create SecCertificate from data."
//        }
//    }
//    public var failureReason: String? {
//        switch self {
//        case let .creation(data: data):
//            return "Data \(data) could not be converted to SecCertificate."
//        }
//    }
//    public var recoverySuggestion: String? {
//        switch self {
//        case .creation:
//            return "Try to use another data."
//        }
//    }
//}

extension DGError.Certificate.Validation: LocalizedError {
    public var errorDescription: String? {
        return "Error is occured on certiicate(s) validation."
    }
    public var failureReason: String? {
        switch self {
        case let .error(error):
            return "Reason: \(error)"
        case let .status(status, secResult: secResult):
            return "Reason: validation failed with OSStatus \(status) secTrustResultType \(secResult)"
        }
    }
    public var recoverySuggestion: String? {
        return "Try to use another certificate(s)."
    }
}
