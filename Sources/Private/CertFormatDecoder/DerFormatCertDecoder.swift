//
//  DerFormatCertDecoder.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

final class DerFormatCertDecoder: NSObject, CertFormatDecoder {
    func decode(certificateData certData: Data) throws -> Certificate {
        return try Certificate(data: certData)
    }

    func decode(certificateFile: CertificateFile) throws -> Certificate {
        let certData = try certificateFile.load()
        return try evaluate(expression: decode(certificateData: certData), onFile: certificateFile)
    }
}

protocol DerDecoder {
    func decode(derData: Data) throws -> Certificate
}

extension DerDecoder {
    func decode(derData: Data) throws -> Certificate {
        return try Certificate(data: derData)
    }
}
