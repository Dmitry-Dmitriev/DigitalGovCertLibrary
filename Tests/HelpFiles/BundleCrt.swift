import Foundation
@testable import DigitalGovCertLibrary

struct CrtFile {
    let name: String
    let ext: CertExtension

    private init(name: String, ext: CertExtension) {
        self.name = name
        self.ext = ext
    }

    static let cerRoot = CrtFile(name: "russiantrustedrootca", ext: .cer)
    static let cerSub = CrtFile(name: "russiantrustedsubca", ext: .cer)
    static let crt = CrtFile(name: "russiantrustedca", ext: .crt)
    static let der = CrtFile(name: "russiantrustedca", ext: .der)
    static let pem = CrtFile(name: "russiantrustedca", ext: .pem)
    static let invalid = CrtFile(name: "invalidCrtFilename", ext: .cer)
}

extension Array where Element == CrtFile {
    var crtNames: [String] {
        return map { $0.name }
    }
}

extension Array where Element == CrtFile {
    static var cerList: [CrtFile] {
        return [.cerRoot, .cerSub]
    }
    static var crtList: [CrtFile] {
        return [.crt]
    }
    static var derList: [CrtFile] {
        return [.der]
    }
    static var pemList: [CrtFile] {
        return [.pem]
    }
    static var invalidCrtList: [CrtFile] {
        return [.invalid]
    }
}
