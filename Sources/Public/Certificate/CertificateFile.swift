//
//  CertificateFile.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

/// no docs
@objc public final class CertificateFile: NSObject {
    public let certBundle: Bundle
    public let certName: String
    public let certExtension: CertExtension
    public let certDecoder: CertFormatDecoder

    /// no docs
    @objc public init(name: String,
                      extension: CertExtension,
                      bundle: Bundle,
                      certDecoder: CertFormatDecoder = UniversalCertDecoder()) {
        self.certName = name
        self.certExtension = `extension`
        self.certBundle = bundle
        self.certDecoder = certDecoder
        super.init()
    }

    @objc public func loadCerificate() throws -> Certificate {
        let certificate = try certDecoder.decode(certificateFile: self)
        return certificate
    }
}
