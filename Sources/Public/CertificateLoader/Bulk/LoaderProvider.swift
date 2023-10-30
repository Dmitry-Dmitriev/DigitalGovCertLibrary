
import Foundation

protocol LoaderProvider {
    func loader(with queue: DispatchQueue) -> CertificateLoader
}
