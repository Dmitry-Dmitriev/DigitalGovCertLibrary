
import Foundation

extension Array where Element == FileCertificateResource {
    private static let digitalGovCertificateNames = ["russiantrustedrootca", "russiantrustedsubca"]
    static let digitalGov: [FileCertificateResource] = {
        digitalGovCertificateNames.map { name in
            FileCertificateResource(certBundle: .resourcesBundle, certName: name, certExtension: .cer)
        }
    }()
}
