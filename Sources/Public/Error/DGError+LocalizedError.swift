//
//  DGError+LocalizedError.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

// MARK: - LocalizedError
extension DGError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .missingFile(name, path):
            return "The file \(name) could not be found at path \(path)"
        case let .certDecoding(name, path):
            return "Certificate \(name) at path \(path) could not be decoded"
        case let .certReading(name, path, _):
            return "It is not possible to read the file \(name) at path \(path)."
        }
    }

    public var failureReason: String? {
        switch self {
        case let .missingFile(name, path):
            return "The file \(name) is missing at path \(path)"
        case let .certDecoding(name, path):
            return "Certificate \(name) at path \(path) could not be decoded with help of pem or der decoder"
        case let .certReading(_, _, reason):
            return "Could not read the file because of the reason: \"\(reason)\""
        }
    }

    public var recoverySuggestion: String? {
        switch self {
        case .missingFile:
            return "Please, try to open another file or correct the file extension"
        case .certDecoding:
            let msgPart1 = "Please, try another file(s) with 'pem', 'der', 'crt', 'cer' extensions"
            let msgPart2 = " or original certificate file was not properly converted to desired extension"
            return msgPart1 + msgPart2
        case .certReading:
            return "Please, try to fix the error of reading the file."
        }
    }
}
