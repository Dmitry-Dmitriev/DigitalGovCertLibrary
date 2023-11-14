import Foundation
@testable import DigitalGovCertLibrary

struct BundleCrt {
    let name: String
    let ext: CertExtension

    private init(name: String, ext: CertExtension) {
        self.name = name
        self.ext = ext
    }

    static let cerRoot = BundleCrt(name: "russiantrustedrootca", ext: .cer)
    static let cerSub = BundleCrt(name: "russiantrustedsubca", ext: .cer)
    static let crt = BundleCrt(name: "russiantrustedca", ext: .crt)
    static let der = BundleCrt(name: "russiantrustedca", ext: .der)
    static let pem = BundleCrt(name: "russiantrustedca", ext: .pem)
    static let invalid = BundleCrt(name: "invalidCrtFilename", ext: .cer)
}

extension Array where Element == BundleCrt {
    var crtNames: [String] {
        return map { $0.name }
    }
}

extension Array where Element == BundleCrt {
    static var cerList: [BundleCrt] {
        return [.cerRoot, .cerSub]
    }
    static var crtList: [BundleCrt] {
        return [.crt]
    }
    static var derList: [BundleCrt] {
        return [.der]
    }
    static var pemList: [BundleCrt] {
        return [.pem]
    }
    static var invalidCrtList: [BundleCrt] {
        return [.invalid]
    }
}
