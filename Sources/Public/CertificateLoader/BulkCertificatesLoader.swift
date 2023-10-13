//
//  BulkCertificatesLoader.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

/// no docs
@objc public final class BulkCertificatesLoader: NSObject, CertificatesLoader {
    /// no docs
    public let certificates: [CertificateFile]
    /// no docs
    @objc public convenience init(certNames: [String],
                                  certExtension: CertExtension,
                                  certbundle: Bundle,
                                  certDecoder: CertFormatDecoder = UniversalCertDecoder()) {
        let certificateTuples = certNames.map { name in
            CertificateTuple(name: name, ext: certExtension, decoder: certDecoder)
        }
        self.init(certificates: certificateTuples, certbundle: certbundle)
    }

    public convenience init(certificates: [CertificateTuple],
                            certbundle: Bundle) {
        let certificateFiles: [CertificateFile] = certificates.map { cert in
                .init(name: cert.name,
                      extension: cert.ext,
                      bundle: certbundle,
                      certDecoder: cert.decoder)
        }
        self.init(certificates: certificateFiles)
    }

    public init(certificates: [CertificateFile]) {
        self.certificates = certificates
        super.init()
    }
    /// no docs
    @objc public func loadCertificates() throws -> [Certificate] {
        return try certificates.map { try $0.loadCerificate() }
    }
}
