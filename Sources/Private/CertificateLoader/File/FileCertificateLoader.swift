import Foundation

final class FileCertificateLoader: CertificateLoader {
    let resource: FileCertificateResource

    init(resource: FileCertificateResource) {
        self.resource = resource
    }

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
                    let fileName = intent.url.fileName
                    let filePath = intent.url.filePath
                    let reason = fileError.localizedDescription
                    let wrappedError = DGError.File.reading(name: fileName, atPath: filePath, reason: reason)
                        .dgError
                    completion(.failure(wrappedError))
                    return
                }

                let reader: CertificateReader = FileURLCertificateReader(url: intent.url)
                let cert = reader.readCertificateResult()
                completion(cert)
            }
        } catch {
            completion(.failure(error))
        }
    }
}
