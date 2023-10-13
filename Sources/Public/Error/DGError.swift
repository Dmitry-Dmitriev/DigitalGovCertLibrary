//
//  DGError.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

public enum DGError: Error {
    case missingFile(name: String, atPath: String)
    case certDecoding(name: String, atPath: String)
    case certReading(name: String, atPath: String, reason: String)
}
