import Foundation

final class RemoteCertificateLoader: CertificateLoader {
    private let remoteResource: RemoteCertificateResource
    private let client: WebClient = SimpleWebClient()

    init(resource: RemoteCertificateResource) {
        self.remoteResource = resource
    }

    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        client.send(requestProvider: remoteResource) { response in
            do {
                guard let data = try response.result.get() else {
                    throw DGError.Network.Response.unexpected(type: String(Certificate.self))
                }
                let universalDecoder: CertificateDecoder = UniversalCertDecoder()
                let cert = try universalDecoder.decode(certificateData: data)
                completion(.success(cert))
            } catch {
                let error = DGError.Network.response(error: .error(error)).dgError
                completion(.failure(error))
            }
        }
    }
}
