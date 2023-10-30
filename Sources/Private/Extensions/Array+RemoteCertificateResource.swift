
import Foundation

extension Array where Element == RemoteCertificateResource {
    private static let certURLs = [
        "https://gu-st.ru/content/Other/doc/russiantrustedca.pem"
    ]
    
    static let digitalGov: [RemoteCertificateResource] = {
        certURLs.map { urlString in
            RemoteCertificateResource(urlString: urlString)
        }
    }()
}
