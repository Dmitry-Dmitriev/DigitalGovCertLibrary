
import Foundation

public protocol CertificateLoader {
    func load(completion: @escaping (Result<Certificate, Error>) -> Void)
}

