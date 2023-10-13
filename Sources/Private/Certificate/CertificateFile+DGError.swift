//
//  CertificateFile+DGError.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

extension CertificateFile {
    var missingFileError: DGError {
        DGError.missingFile(name: fullFileName, atPath: fileLocation)
    }
    var decodingFileError: DGError {
        DGError.certDecoding(name: fullFileName,
                                   atPath: fileLocation)

    }
    func readingFileError(reason: String) -> DGError {
        DGError.certReading(name: fullFileName, atPath: fileLocation, reason: reason)
    }

    var fullFileName: String {
        certName + "." + certExtension.string
    }

    var fileLocation: String {
        certBundle.bundlePath
    }
}
