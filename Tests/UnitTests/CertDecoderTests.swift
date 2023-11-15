import XCTest
@testable import DigitalGovCertLibrary

final class CertDecoderTests: XCTestCase {
    func test1() {
        let formatWithTwoPlaceHolders = "It is not possible to read the file %@ at path %@."
        let stringWithThreeArguments = String(format: formatWithTwoPlaceHolders, "file", "error", "rrrr")
        let expectedResult = "It is not possible to read the file file at path error."
        XCTAssertEqual(stringWithThreeArguments, expectedResult)
    }

    func testCerFormat() {
        let cerRoot = FileCertificateResource(crtFile: .cerRoot)
        let rootExpectation = XCTestExpectation(description: "Load a root cer format")
        
        let cerSub = FileCertificateResource(crtFile: .cerSub)
        let subExpectation = XCTestExpectation(description: "Load a sub cer format")
        
        testCertificateLoad(resource: cerRoot, expectation: rootExpectation)
        testCertificateLoad(resource: cerSub, expectation: subExpectation)
        wait(for: [rootExpectation, subExpectation], timeout: 2)
    }

    func testDerFormat() {
        let der = FileCertificateResource(crtFile: .der)
        let expectation = XCTestExpectation(description: "Load a der format")
        testCertificateLoad(resource: der, expectation: expectation)
        wait(for: [expectation], timeout: 2)
    }

    func testCrtFormat() {
        let der = FileCertificateResource(crtFile: .crt)
        let expectation = XCTestExpectation(description: "Load a crt format")
        testCertificateLoad(resource: der, expectation: expectation)
        wait(for: [expectation], timeout: 2)
    }

    func testPemFormat() {
        let der = FileCertificateResource(crtFile: .pem)
        let expectation = XCTestExpectation(description: "Load a pem format")
        testCertificateLoad(resource: der, expectation: expectation)
        wait(for: [expectation], timeout: 2)
    }
    
    private func testCertificateLoad(resource: FileCertificateResource, expectation: XCTestExpectation) {
        let cerRoot = FileCertificateResource(crtFile: .cerRoot)
        cerRoot.certificateLoader.load { result in
            let certificate = try? result.get()
            XCTAssertNotNil(certificate)
            expectation.fulfill()
        }
    }
}
