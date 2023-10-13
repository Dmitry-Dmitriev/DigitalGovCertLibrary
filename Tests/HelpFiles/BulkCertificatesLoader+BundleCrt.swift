//
//  BulkCertificatesLoader+BundleCrt.swift
//  digital.gov.rus.cert.supportTests
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation
@testable import DigitalGovCertLibrary

extension BulkCertificatesLoader {
    convenience init(bundeledCrts: [BundleCrt]) {
        let tuples = bundeledCrts.map {
            CertificateTuple(name: $0.name,
                             ext: $0.ext,
                             decoder: UniversalCertDecoder()
            )
        }
        self.init(certificates: tuples, certbundle: .resourcesBundle)
    }
}
