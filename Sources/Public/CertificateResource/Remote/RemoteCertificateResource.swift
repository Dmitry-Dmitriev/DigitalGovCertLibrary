

import Foundation

@objc open class RemoteCertificateResource: NSObject, WebRequestProvider, CertificateLoadableResource {
    // https://gu-st.ru/content/Other/doc/russiantrustedca.pem
    let urlString: String
    public init(urlString: String) {
        self.urlString = urlString
        super.init()
    }
    
    @objc open func resourceURL() throws -> URL {
        guard let url = URL(string: urlString) else {
            throw DGError.Converting.urlFromString(urlString)
        }
        return url
    }
    
    @objc open func makeRequest() throws -> URLRequest {
        return try URLRequest(url: resourceURL())
    }
    
    public var request: URLRequest {
        get throws {
            try makeRequest()
        }
    }
    
    open override var hash: Int {
        var hasher = Hasher()
        hasher.combine(urlString)
        return hasher.finalize()
    }
    
    public var certificateLoader: CertificateLoader {
        return RemoteCertificateLoader(resource: self)
    }
}
