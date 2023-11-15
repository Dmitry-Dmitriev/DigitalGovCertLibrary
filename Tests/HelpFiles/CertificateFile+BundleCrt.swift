import Foundation
@testable import DigitalGovCertLibrary

 extension FileCertificateResource {
    convenience init(crtFile: CrtFile) {
        self.init(certBundle: .resourcesBundle,
                  certName: crtFile.name,
                  certExtension: crtFile.ext)
    }
 }
