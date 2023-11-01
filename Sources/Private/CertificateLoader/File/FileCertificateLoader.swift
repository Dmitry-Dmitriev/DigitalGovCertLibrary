

import Foundation


final class FileCertificateLoader: CertificateLoader {
    let resource: FileCertificateResource

    init(resource: FileCertificateResource) {
        self.resource = resource
    }
    
//    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
//        do {
//            let url = try resource.resourceURL()
//            let reader: CertificateReader = FileURLCertificateReader(url: url)
//            let cert = reader.readCertificate()
//            completion(cert)
//        }
//        catch {
//            completion(.failure(error))
//        }
//    }
//    
    private let workingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.underlyingQueue = DispatchQueue.concurrent
        return queue
    }()
    
    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        do {
            let url = try resource.resourceURL()
            let coordinator = NSFileCoordinator()
            let intent = NSFileAccessIntent.readingIntent(with: url)
            coordinator.coordinate(with: [intent],
                                   queue: workingQueue) { fileError in
                if let fileError {
                    completion(.failure(fileError))
                    return
                }

                let reader: CertificateReader = FileURLCertificateReader(url: intent.url)
                let cert = reader.readCertificateResult()
                completion(cert)
            }
        }
        catch {
            completion(.failure(error))
        }
    }
}
