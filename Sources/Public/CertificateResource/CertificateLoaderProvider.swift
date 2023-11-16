import Foundation

/// Any object that provides certificate loader
public protocol CertificateLoaderProvider {
    /// Certificate loader itself
    var certificateLoader: CertificateLoader { get }
}
