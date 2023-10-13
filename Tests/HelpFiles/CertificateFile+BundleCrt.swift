//
//  CertificateFile+BundleCrt.swift
//  digital.gov.rus.cert.supportTests
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation
@testable import DigitalGovCertLibrary

extension CertificateFile {
    convenience init(bundleCrt: BundleCrt,
                     certDecoder: CertFormatDecoder) {
        self.init(name: bundleCrt.name,
                  extension: bundleCrt.ext,
                  bundle: .resourcesBundle,
                  certDecoder: certDecoder)
    }
}
