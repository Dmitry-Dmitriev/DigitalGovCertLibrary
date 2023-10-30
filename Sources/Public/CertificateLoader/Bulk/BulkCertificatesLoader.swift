
import Foundation

final class BulkCertificatesLoader: ManagableLoader {
    private let resources: [CertificateResource & LoaderProvider]
    
    convenience init(fileResources: [FileCertificateResource]) {
        self.init(resources: fileResources)
    }
    
    convenience init(remoteResources: [RemoteCertificateResource]) {
        self.init(resources: remoteResources)
    }
    
    private init(resources: [CertificateResource & LoaderProvider]) {
        self.resources = resources
    }

    func load(completion: @escaping (BulkLoadResult) -> Void) {
        let group = DispatchGroup()
        let syncqueue = DispatchQueue.serial
        let workQueue = DispatchQueue.concurrent
        
        var array = [Certificate]()
        var failResources: [BulkErrorLoadItem] = []
       
        resources.forEach { resource in
            let loader = resource.loader(with: workQueue)
            group.enter()
            loader.load { result in
                do {
                    let cert = try result.get()
                    syncqueue.async {
                        array.append(cert)
                    }
                }
                catch {
                    let item = BulkErrorLoadItem(certificateResource: resource, error: error)
                    syncqueue.async {
                        failResources.append(item)
                    }
                }
                group.leave()
            }
        }

        group.notify(queue: syncqueue) {
            let result = BulkLoadResult(certs: array,
                                        failResources: failResources)
            completion(result)
        }
    }
}
