//
//  PemFormatCertDecoder.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

final class PemFormatCertDecoder: NSObject, CertFormatDecoder {
    private let certBegin = "-----BEGIN CERTIFICATE-----"
    private let certEnd = "-----END CERTIFICATE-----"

    func decode(certificateData certData: Data) throws -> Certificate {
        guard let fileContent = String(data: certData, encoding: .utf8) else {
            throw DGError.certDecoding(name: .empty, atPath: .empty)
        }

        var base64 = fileContent
            .replacingOccurrences(of: certBegin, with: String.empty)
            .replacingOccurrences(of: certEnd, with: String.empty)

        if #available(iOS 16.0, *), #available(OSX 13.0, *) {
            base64 = base64.split(separator: Character.linebreak).joined()
            
        } else {
            base64 = base64.components(separatedBy: Character.linebreak).joined()
        }

        guard let certData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            throw DGError.certDecoding(name: .empty, atPath: .empty)
        }

        return try Certificate(data: certData)
    }

    func decode(certificateFile: CertificateFile) throws -> Certificate {
        let rawCertData = try certificateFile.load()
        return try evaluate(expression: decode(certificateData: rawCertData),
                            onFile: certificateFile)
    }
}


protocol PemDecoder {
    func decode(pemData: Data) throws -> Certificate
}

extension PemDecoder {
    func decode(pemData: Data) throws -> Certificate {
        guard let fileContent = String(data: pemData, encoding: .utf8) else {
            throw DGError.certDecoding(name: .empty, atPath: .empty)
        }

        var base64 = fileContent
            .replacingOccurrences(of: certBegin, with: String.empty)
            .replacingOccurrences(of: certEnd, with: String.empty)

        if #available(iOS 16.0, *), #available(OSX 13.0, *) {
            base64 = base64.split(separator: Character.linebreak).joined()
            
        } else {
            base64 = base64.components(separatedBy: Character.linebreak).joined()
        }

        guard let certData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            throw DGError.certDecoding(name: .empty, atPath: .empty)
        }

        return try Certificate(data: certData)
        
    }
}

private extension PemDecoder {
    var certBegin: String {
        return "-----BEGIN CERTIFICATE-----"
    }
    var certEnd: String {
        return "-----END CERTIFICATE-----"
    }
}
