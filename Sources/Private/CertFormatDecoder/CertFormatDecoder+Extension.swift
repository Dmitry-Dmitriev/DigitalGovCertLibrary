//
//  CertFormatDecoder+Extension.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

extension CertFormatDecoder {
    func evaluate<T>(expression: @autoclosure () throws -> T?,
                     onFile certificateFile: CertificateFile) throws -> T {
        guard let result = try expression() else {
            throw certificateFile.decodingFileError
        }
        return result
    }
}
