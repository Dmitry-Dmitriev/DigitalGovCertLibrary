//
//  CertExtension.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 03.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

@objc public enum CertExtension: Int {
    case crt
    case der
    case cer
    case pem
}

extension CertExtension {
    var string: String {
        switch self {
        case .cer: return "cer"
        case .crt: return "crt"
        case .der: return "der"
        case .pem: return "pem"
        }
    }
}
