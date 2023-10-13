//
//  CertificateTuple.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

/// no docs
public struct CertificateTuple {
    /// no docs
    public let name: String
    /// no docs
    public let ext: CertExtension
    /// no docs
    public let decoder: CertFormatDecoder

    /// no docs
    public init(name: String, ext: CertExtension, decoder: CertFormatDecoder) {
        self.name = name
        self.ext = ext
        self.decoder = decoder
    }
}
