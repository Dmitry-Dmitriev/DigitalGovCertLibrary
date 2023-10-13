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
}

extension String {
    init(_ any: Any) {
        self.init(describing: any)
    }
}
