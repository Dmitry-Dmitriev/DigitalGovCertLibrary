import Foundation

/// Any object that can load certificate
public protocol CertificateLoader {
    /// Method to load certificate
    func load(completion: @escaping (Result<Certificate, Error>) -> Void)
}
