import Foundation

// swiftlint:disable:next final_class
@objc open class RemoteCertificateResource: NSObject, WebRequestProvider, CertificateLoadableResource {
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
        let url = try resourceURL()
        return URLRequest(url: url)
    }

    public var request: URLRequest {
        get throws {
            do {
                return try makeRequest()
            } catch {
                throw DGError.Network.request(self, error: error).dgError
            }
        }
    }

    public var certificateLoader: CertificateLoader {
        return RemoteCertificateLoader(resource: self)
    }
}
