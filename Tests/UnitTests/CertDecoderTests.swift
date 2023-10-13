//
//  CertDecoderTests.swift
//  digital.gov.rus.cert.supportTests
//
//  Created by dmitry.dmitriev on 11.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import XCTest
@testable import DigitalGovCertLibrary

final class CertDecoderTests: XCTestCase {
    func testCerFormat() {
        let cerPem = CertificateFile(bundleCrt: .cerRoot, certDecoder: PemFormatCertDecoder())
        XCTAssertNoThrow(try cerPem.loadCerificate())
        let cerDer = CertificateFile(bundleCrt: .cerRoot, certDecoder: DerFormatCertDecoder())
        XCTAssertThrowsError(try cerDer.loadCerificate())
    }

    func testDerFormat() {
        let derPem = CertificateFile(bundleCrt: .der, certDecoder: PemFormatCertDecoder())
        XCTAssertThrowsError(try derPem.loadCerificate())
        let derDer = CertificateFile(bundleCrt: .der, certDecoder: DerFormatCertDecoder())
        XCTAssertNoThrow(try derDer.loadCerificate())
    }

    func testCrtFormat() {
        let crtPem = CertificateFile(bundleCrt: .crt, certDecoder: PemFormatCertDecoder())
        XCTAssertThrowsError(try crtPem.loadCerificate())
        let crtDer = CertificateFile(bundleCrt: .crt, certDecoder: DerFormatCertDecoder())
        XCTAssertNoThrow(try crtDer.loadCerificate())
    }

    func testPemFormat() {
        let pemPem = CertificateFile(bundleCrt: .pem, certDecoder: PemFormatCertDecoder())
        XCTAssertNoThrow(try pemPem.loadCerificate())
        let pemDer = CertificateFile(bundleCrt: .pem, certDecoder: DerFormatCertDecoder())
        XCTAssertThrowsError(try pemDer.loadCerificate())
    }
}
