import XCTest
@testable import DigitalGovCertLibrary

final class BulkCertLoaderTests: XCTestCase {
    func testRemoteLoad() {
        let cerBulkCertLoader = BulkCertificatesLoader(remoteResources: .digitalGov)
        let expectedSuccessLoadsCount = [RemoteCertificateResource].self.digitalGov.count
        let expectation = XCTestExpectation(description: "Load a cert file from remote asynchronously.")
        testSuccessBulkCertLoader(cerBulkCertLoader: cerBulkCertLoader,
                                  expectedSuccessLoadsCount: expectedSuccessLoadsCount,
                                  expectation: expectation)
        wait(for: [expectation], timeout: 5)
    }

    func testCerBulkCertLoader() {
        let crtBulkCertLoader = BulkCertificatesLoader(crtFiles: .cerList)
        let expectedSuccessLoadsCount = [CrtFile].self.cerList.count
        let expectation = XCTestExpectation(description: "Load a crt file from disk asynchronously.")
        testSuccessBulkCertLoader(cerBulkCertLoader: crtBulkCertLoader,
                                  expectedSuccessLoadsCount: expectedSuccessLoadsCount,
                                  expectation: expectation)
        wait(for: [expectation], timeout: 1)
    }

    func testCrtBulkCertLoader() {
        let crtBulkCertLoader = BulkCertificatesLoader(crtFiles: .crtList)
        let expectedSuccessLoadsCount = [CrtFile].self.crtList.count
        let expectation = XCTestExpectation(description: "Load a crt file from disk asynchronously.")
        testSuccessBulkCertLoader(cerBulkCertLoader: crtBulkCertLoader,
                                  expectedSuccessLoadsCount: expectedSuccessLoadsCount,
                                  expectation: expectation)
        wait(for: [expectation], timeout: 1)
    }

    func testDerBulkCertLoader() {
        let derBulkCertLoader = BulkCertificatesLoader(crtFiles: .derList)
        let expectedSuccessLoadsCount = [CrtFile].self.derList.count
        let expectation = XCTestExpectation(description: "Load a der file from disk asynchronously.")
        testSuccessBulkCertLoader(cerBulkCertLoader: derBulkCertLoader,
                                  expectedSuccessLoadsCount: expectedSuccessLoadsCount,
                                  expectation: expectation)
        wait(for: [expectation], timeout: 1)

    }

    func testPemBulkCertLoader() {
        let pemBulkCertLoader = BulkCertificatesLoader(crtFiles: .pemList)
        let expectedSuccessLoadsCount = [CrtFile].self.pemList.count
        let expectation = XCTestExpectation(description: "Load a pem file from disk asynchronously.")
        testSuccessBulkCertLoader(cerBulkCertLoader: pemBulkCertLoader,
                                  expectedSuccessLoadsCount: expectedSuccessLoadsCount,
                                  expectation: expectation)
        wait(for: [expectation], timeout: 1)
    }

    func testInvalidBulkCertLoader() {
        let invalidBulkCertLoader = BulkCertificatesLoader(crtFiles: .invalidCrtList)
        let expectedFailLoadsCount = [CrtFile].self.invalidCrtList.count
        let expectation = XCTestExpectation(description: "Load a invalid file from disk asynchronously.")
        invalidBulkCertLoader.load { result in
            XCTAssertTrue(result.isFailed)
            XCTAssertEqual(result.certs.count, 0)
            XCTAssertEqual(result.failResources.count, expectedFailLoadsCount)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    private func testSuccessBulkCertLoader(cerBulkCertLoader: BulkCertificatesLoader,
                                           expectedSuccessLoadsCount: Int,
                                           expectation: XCTestExpectation) {
        cerBulkCertLoader.load { result in
            XCTAssertFalse(result.isFailed)
            XCTAssertEqual(result.certs.count, expectedSuccessLoadsCount)
            XCTAssertEqual(result.failResources.count, 0)
            expectation.fulfill()
        }
    }
}
