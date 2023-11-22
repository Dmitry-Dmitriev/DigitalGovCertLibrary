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

import Foundation

/// Universal object that unions different ways of decoding Certificate
@objc public final class UniversalCertDecoder: NSObject, CertificateDecoder {
    private let derDecoder: DerDecoder = DerFormatCertDecoder()
    private let pemDecoder: PemDecoder = PemFormatCertDecoder()

    /// Default initializer
    public override init() {
        super.init()
    }

//    @objc public func decode(certificateData: Data) throws -> Certificate {
//        let pemResult = Result(autoCatching: try pemDecoder.decode(pemData: certificateData))
//        if let pemFile = try? pemResult.get() {
//            return pemFile
//        }
//
//        let derResult = Result(autoCatching: try derDecoder.decode(derData: certificateData))
//        if let derFile = try? derResult.get() {
//            return derFile
//        }
//        let results = [pemResult, derResult]
//        throw DGError.Certificate.Decoding.universal(results).dgError
//    }

    /// Tries to create Certificate from raw data
    @objc public func decode(certificateData: Data) throws -> Certificate {
        let pemResult = Result(autoCatching: try decode(pemData: certificateData))
        if let pemFile = try? pemResult.get() {
            return pemFile
        }

        let derResult = Result(autoCatching: try decode(derData: certificateData))
        if let derFile = try? derResult.get() {
            return derFile
        }
        let results = [pemResult, derResult]
        throw DGError.Certificate.Decoding.universal(results).dgError
    }
}

extension UniversalCertDecoder: PemDecoder, DerDecoder {}
