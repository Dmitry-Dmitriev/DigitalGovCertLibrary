import Foundation

final class RemoteCertificateLoader: CertificateLoader {
    private let remoteResource: RemoteCertificateResource
    private let client: WebClient = SimpleWebClient()

    init(resource: RemoteCertificateResource) {
        self.remoteResource = resource
    }

    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        client.send(requestProvider: remoteResource) { response in
            completion(response.result)
        }
    }
}
