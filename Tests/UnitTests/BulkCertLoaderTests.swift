
import XCTest
@testable import DigitalGovCertLibrary

final class BulkCertLoaderTests: XCTestCase {
    func testCerBulkCertLoader() {
        let cerBulkCertLoader = BulkCertificatesLoader(bundeledCrts: .cerList)
        let certificatesList = try? cerBulkCertLoader.loadCertificates()
        let certificates = certificatesList ?? []
        XCTAssertEqual(certificates.count, cerBulkCertLoader.certificates.count)
    }

    func testCrtBulkCertLoader() {
        let crtBulkCertLoader = BulkCertificatesLoader(bundeledCrts: .crtList)
        let certificatesList = try? crtBulkCertLoader.loadCertificates()
        let certificates = certificatesList ?? []
        XCTAssertEqual(certificates.count, crtBulkCertLoader.certificates.count)
    }

    func testDerBulkCertLoader() {
        let derBulkCertLoader = BulkCertificatesLoader(bundeledCrts: .derList)
        let certificatesList = try? derBulkCertLoader.loadCertificates()
        let certificates = certificatesList ?? []
        XCTAssertEqual(certificates.count, derBulkCertLoader.certificates.count)
    }

    func testPemBulkCertLoader() {
        let pemBulkCertLoader = BulkCertificatesLoader(bundeledCrts: .pemList)
        let certificatesList = try? pemBulkCertLoader.loadCertificates()
        let certificates = certificatesList ?? []
        XCTAssertEqual(certificates.count, pemBulkCertLoader.certificates.count)
    }

    func testInvalidBulkCertLoader() {
        let invalidBulkCertLoader = BulkCertificatesLoader(bundeledCrts: .invalidCrtList)
        let certificatesList = try? invalidBulkCertLoader.loadCertificates()
        let certificates = certificatesList ?? []
        XCTAssertNotEqual(certificates.count, invalidBulkCertLoader.certificates.count)
    }
}
