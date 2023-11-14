import Foundation

final class OnQueueCertificateLoader: CertificateLoader {
    private let makeCertificateLoader: () -> CertificateLoader
    private let queue: DispatchQueue

    init(queue: DispatchQueue, makeClosure: @autoclosure @escaping () -> CertificateLoader) {
        self.makeCertificateLoader = makeClosure
        self.queue = queue
    }

    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        let certificateloader = makeCertificateLoader()
        queue.async {
            certificateloader.load(completion: completion)
        }
    }
}
