import Foundation
@testable import DigitalGovCertLibrary

 extension BulkCertificatesLoader {
    convenience init(crtFiles: [CrtFile]) {
        let fileResources = crtFiles.map { FileCertificateResource(crtFile: $0) }
        self.init(fileResources: fileResources)
    }
 }
