//
//  CertificatesLoader.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 03.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

@objc public protocol CertificatesLoader: NSObjectProtocol {
    func loadCertificates() throws -> [Certificate]
}
