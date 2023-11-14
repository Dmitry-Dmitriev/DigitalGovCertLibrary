import XCTest
@testable import DigitalGovCertLibrary

final class CertDecoderTests: XCTestCase {
    func test1() {
        let frmat = "It is not possible to read the file %@ at path %@."
        let string = String(format: frmat, "file", "error", "rrrr")
        let final = "It is not possible to read the file file at path error."
        XCTAssertEqual(string, final)
    }
//    func testCerFormat() {
//        let cerPem = CertificateFile(bundleCrt: .cerRoot, certDecoder: PemFormatCertDecoder())
//        XCTAssertNoThrow(try cerPem.loadCerificate())
//        let cerDer = CertificateFile(bundleCrt: .cerRoot, certDecoder: DerFormatCertDecoder())
//        XCTAssertThrowsError(try cerDer.loadCerificate())
//    }
//
//    func testDerFormat() {
//        let derPem = CertificateFile(bundleCrt: .der, certDecoder: PemFormatCertDecoder())
//        XCTAssertThrowsError(try derPem.loadCerificate())
//        let derDer = CertificateFile(bundleCrt: .der, certDecoder: DerFormatCertDecoder())
//        XCTAssertNoThrow(try derDer.loadCerificate())
//    }
//
//    func testCrtFormat() {
//        let crtPem = CertificateFile(bundleCrt: .crt, certDecoder: PemFormatCertDecoder())
//        XCTAssertThrowsError(try crtPem.loadCerificate())
//        let crtDer = CertificateFile(bundleCrt: .crt, certDecoder: DerFormatCertDecoder())
//        XCTAssertNoThrow(try crtDer.loadCerificate())
//    }
//
//    func testPemFormat() {
//        let pemPem = CertificateFile(bundleCrt: .pem, certDecoder: PemFormatCertDecoder())
//        XCTAssertNoThrow(try pemPem.loadCerificate())
//        let pemDer = CertificateFile(bundleCrt: .pem, certDecoder: DerFormatCertDecoder())
//        XCTAssertThrowsError(try pemDer.loadCerificate())
//    }
}
