import Foundation

extension CertExtension {
    static var list: [String] {
        return allCases.map { $0.string }
    }
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
