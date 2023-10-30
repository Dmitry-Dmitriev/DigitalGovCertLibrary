
import Foundation

@objc public enum CertExtension: Int {
    case crt
    case der
    case cer
    case pem
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
