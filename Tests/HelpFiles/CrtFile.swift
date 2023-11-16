import Foundation
@testable import DigitalGovCertLibrary

struct CrtFile {
    let name: String
    let ext: CertExtension

    private init(name: String, ext: CertExtension) {
        self.name = name
        self.ext = ext
    }
}

extension CrtFile {
    static let cerRoot = CrtFile(name: "russiantrustedrootca", ext: .cer)
    static let cerSub = CrtFile(name: "russiantrustedsubca", ext: .cer)
    static let crt = CrtFile(name: "russiantrustedca", ext: .crt)
    static let der = CrtFile(name: "russiantrustedca", ext: .der)
    static let pem = CrtFile(name: "russiantrustedca", ext: .pem)
    static let invalid = CrtFile(name: "invalidCrtFilename", ext: .cer)
}
