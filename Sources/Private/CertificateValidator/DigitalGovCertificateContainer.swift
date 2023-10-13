//
//  DigitalGovCertificateContainer.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

final class DigitalGovCertificateContainer {
    private let digitalGovCertificateNames = ["russiantrustedrootca", "russiantrustedsubca"]
    private let digitalGovCertLoader: BulkCertificatesLoader

    init(digitalGovCertLoader: BulkCertificatesLoader) {
        self.digitalGovCertLoader = digitalGovCertLoader
    }

    lazy var certificates: [Certificate] = {
        let digitalGovCertificates = digitalGovCertificates
        assert(!digitalGovCertificates.isEmpty, assertMessage)
        return digitalGovCertificates
    }()

    private var digitalGovCertificates: [Certificate] {
        let certificates = try? digitalGovCertLoader.loadCertificates()
        return certificates ?? []
    }

    private var assertMessage: String {
        "\(String(Self.self)): could not load preinstalled certificates \(certNamesList)."
    }
    private var certNamesList: String {
        digitalGovCertLoader.certificates.map { $0.fullFileName }.joined(separator: .comma)
    }
}
