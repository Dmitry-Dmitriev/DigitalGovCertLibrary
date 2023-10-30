//
//  String+Extension.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 03.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

extension String {
    static let empty = ""
    static let linebreak = "\n"
    static let comma = ","
    static let dot = "."
}

extension String {
    init(_ any: Any) {
        self.init(describing: any)
    }
}

extension Certificate {
    convenience init(data: Data) throws {
        guard let certificate = SecCertificateCreateWithData(nil, data as CFData) else {
            throw DGError.Certificate.creation(data: data)
        }

        self.init(certificate: certificate)
    }
}
