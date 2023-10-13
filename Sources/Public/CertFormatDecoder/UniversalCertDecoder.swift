//
//  UniversalCertDecoder.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

@objc public final class UniversalCertDecoder: NSObject, CertFormatDecoder {
    private let derDecoder = DerFormatCertDecoder()
    private let pemDecoder = PemFormatCertDecoder()

    @objc public func decode(certificateFile: CertificateFile) throws -> Certificate {
        let certData = try certificateFile.load()
        return try evaluate(expression: decode(certificateData: certData), onFile: certificateFile)
    }

    @objc public func decode(certificateData: Data) throws -> Certificate {
        if let pemFile = try? pemDecoder.decode(certificateData: certificateData) {
            return pemFile
        }
        if let derFile = try? derDecoder.decode(certificateData: certificateData) {
            return derFile
        }

        throw DGError.certDecoding(name: .empty, atPath: .empty)
    }
}
