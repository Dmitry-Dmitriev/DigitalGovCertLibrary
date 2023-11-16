import Foundation

/// Supported certificate extensions 
@objc public enum CertExtension: Int, CaseIterable {
    case crt
    case der
    case cer
    case pem
}
