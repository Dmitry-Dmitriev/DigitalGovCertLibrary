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
        guard let certificate = SecCertificateCreateWithData(nil, certData as CFData) else {
            throw DGError.certDecoding(name: .empty, atPath: .empty)
        }

        return .init(certificate: certificate)
    }

    func decode(certificateFile: CertificateFile) throws -> Certificate {
        let certData = try certificateFile.load()
        return try evaluate(expression: decode(certificateData: certData), onFile: certificateFile)
    }
}
