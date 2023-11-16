import Foundation

/// Certificate resource that can be loaded from network
@objc open class RemoteCertificateResource: NSObject, WebRequestProvider, CertificateLoadableResource {
    let urlString: String

    /// Designated initializer
    /// - Parameters:
    ///    - urlString: string representation of remote url
    public init(urlString: String) {
        self.urlString = urlString
        super.init()
    }

    /// Certiicate resource remote url
    @objc
    open func resourceURL() throws -> URL {
        guard let url = URL(string: urlString) else {
            throw DGError.Converting.urlFromString(urlString)
        }
        return url
    }

    /// Tries to create request 
    @objc
    open func makeRequest() throws -> URLRequest {
        let url = try resourceURL()
        return URLRequest(url: url)
    }

    /// URLRequest ro remote certificate resource
    open var request: URLRequest {
        get throws {
            do {
                return try makeRequest()
            } catch {
                let error = DGError.Network.request(self, error: error)
                throw error.dgError
            }
        }
    }

    /// Certificate loader of remote resource
    open var certificateLoader: CertificateLoader {
        return RemoteCertificateLoader(resource: self)
    }
}
