

import Foundation

final class FileCertificateLoader: CertificateLoader {
    let resource: FileCertificateResource

    init(resource: FileCertificateResource) {
        self.resource = resource
    }
    
    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        do {
            let url = try resource.makeURL()
            let data = try Data(contentsOf: url)
            let decoder = UniversalCertDecoder()
            let cert = try decoder.decode(certificateData: data)
            completion(.success(cert))
        }
        catch {
            completion(.failure(error))
        }
    }
    
//    private let workingQueue: OperationQueue = {
//        let queue = OperationQueue()
//        queue.underlyingQueue = DispatchQueue.concurrent
//        return queue
//    }()
//    
//    func load1(completion: @escaping (Result<Certificate, Error>) -> Void) {
//            do {
//                let url = try resource.makeURL()
//                let coordinator = NSFileCoordinator()
//                let intent = NSFileAccessIntent.readingIntent(with: url)
//                coordinator.coordinate(with: [intent], queue: workingQueue) { error in
//                    if let error {
//                        completion(.failure(error))
//                        return
//                    }
//                    
//                    let decoder = UniversalCertDecoder()
//                    let data = try Data(contentsOf: intent.url)
//                    let cert = try decoder.decode(certificateData: data)
//                    completion(.success(cert))
//                }
//        }
//        catch {
//            completion(.failure(error))
//        }
//    }
}
