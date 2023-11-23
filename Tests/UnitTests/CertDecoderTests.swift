//  DigitalGovCertLibrary

//  Copyright (c) 2023-Present DigitalGovCertLibrary Team - https://github.com/myTargetSDK/DigitalGovCertLibrary-iOS
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import XCTest
@testable import DigitalGovCertLibrary

final class CertDecoderTests: XCTestCase {
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
