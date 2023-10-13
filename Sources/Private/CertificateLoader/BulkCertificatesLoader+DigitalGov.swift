//
//  BulkCertificatesLoader+DigitalGov.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

extension BulkCertificatesLoader {
    private static let digitalGovCertificateNames = ["russiantrustedrootca", "russiantrustedsubca"]
    static let digitalGov = BulkCertificatesLoader(certNames: digitalGovCertificateNames,
                                                   certExtension: .cer,
                                                   certbundle: .resourcesBundle)
}
