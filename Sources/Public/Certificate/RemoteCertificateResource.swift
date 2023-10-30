

import Foundation

final class RemoteCertificateResource: NSObject, CertificateResource, WebRequestProvider, LoaderProvider {
    // https://gu-st.ru/content/Other/doc/russiantrustedca.pem
    let urlString: String
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func makeURL() throws -> URL {
        guard let url = URL(string: urlString) else {
            throw DGError.certDecoding(name: .empty, atPath: .empty)
        }
        return url
    }
    
    func makeRequest() throws -> URLRequest {
        return try URLRequest(url: makeURL())
    }
    
    var request: URLRequest {
        get throws {
            try makeRequest()
        }
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(urlString)
        return hasher.finalize()
    }
    
    func loader(with queue: DispatchQueue) -> CertificateLoader {
        
        return OnQueueCertificateLoader(queue: queue, closure:
                                            RemoteCertificateLoader(resource: self))
    }
}
