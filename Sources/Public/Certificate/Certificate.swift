//
//  Certificate.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 03.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

/// no docs
@objc public final class Certificate: NSObject {
    /// no docs
    @objc public let certificate: SecCertificate

    internal init(certificate: SecCertificate) {
        self.certificate = certificate
    }
}
