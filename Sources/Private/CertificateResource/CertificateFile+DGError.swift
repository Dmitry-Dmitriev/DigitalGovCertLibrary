//
//
// import Foundation
//
// extension CertificateFile {
//    var missingFileError: DGError {
//        DGError.missingFile(name: fullFileName, atPath: fileLocation)
//    }
//    var decodingFileError: DGError {
//        DGError.certDecoding(name: fullFileName,
//                                   atPath: fileLocation)
//
//    }
//    func readingFileError(reason: String) -> DGError {
//        DGError.certReading(name: fullFileName, atPath: fileLocation, reason: reason)
//    }
//
//    var fullFileName: String {
//        certName + .dot + certExtension.string
//    }
//
//    var fileLocation: String {
//        certBundle.bundlePath
//    }
// }
