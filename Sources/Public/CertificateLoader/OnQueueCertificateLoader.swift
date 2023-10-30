

import Foundation

final class OnQueueCertificateLoader: CertificateLoader {
    private let makeloader: () -> CertificateLoader
    private let queue: DispatchQueue
    
    init(queue: DispatchQueue, closure: @autoclosure @escaping () -> CertificateLoader) {
        self.makeloader = closure
        self.queue = queue
    }
    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        let loader = makeloader()
        queue.async {
            loader.load(completion: completion)
        }
    }
}
