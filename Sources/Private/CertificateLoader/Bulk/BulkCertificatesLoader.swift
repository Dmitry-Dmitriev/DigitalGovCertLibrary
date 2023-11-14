import Foundation

final class BulkCertificatesLoader: Loader {
    private let resources: [CertificateLoadableResource]

    convenience init(fileResources: [FileCertificateResource]) {
        self.init(resources: fileResources)
    }

    convenience init(remoteResources: [RemoteCertificateResource]) {
        self.init(resources: remoteResources)
    }

    private init(resources: [CertificateLoadableResource]) {
        self.resources = resources
    }

    func load(completion: @escaping (BulkLoadResult) -> Void) {
        let group = DispatchGroup()
        let synchronizedQueue = DispatchQueue.serial
        let workQueue = DispatchQueue.concurrent

        var array = [Certificate]()
        var failResources: [BulkErrorLoadItem] = []

        resources.forEach { resource in
            let certificateLoader = OnQueueCertificateLoader(queue: workQueue,
                                                             makeClosure: resource.certificateLoader)
            group.enter()
            certificateLoader.load { result in
                do {
                    let cert = try result.get()
                    synchronizedQueue.async {
                        array.append(cert)
                        group.leave()
                    }
                } catch {
                    let item = BulkErrorLoadItem(certificateResource: resource, error: error)
                    synchronizedQueue.async {
                        failResources.append(item)
                        group.leave()
                    }
                }
            }
        }

        group.notify(queue: synchronizedQueue) {
            let result = BulkLoadResult(certs: array,
                                        failResources: failResources)
            completion(result)
        }
    }
}
