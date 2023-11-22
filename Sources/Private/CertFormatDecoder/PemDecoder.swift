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

protocol PemDecoder {
    func decode(pemData: Data) throws -> Certificate
}

extension PemDecoder {
    func decode(pemData: Data) throws -> Certificate {
        do {
            return try decode(pem: pemData)
        } catch {
            throw DGError.Certificate.Decoding.pem(error).dgError
        }
    }
}

private extension PemDecoder {
    func decode(pem: Data) throws -> Certificate {
        guard let fileContent = String(data: pem, encoding: .utf8) else {
            throw DGError.Converting.stringFromData(pem)
        }

        var base64 = fileContent
            .replacingOccurrences(of: certBegin, with: String.empty)
            .replacingOccurrences(of: certEnd, with: String.empty)

        if #available(iOS 16.0, *), #available(OSX 13.0, *) {
            base64 = base64.split(separator: Character.linebreak).joined()

        } else {
            base64 = base64.components(separatedBy: Character.linebreak).joined()
        }

        guard let certData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            throw DGError.Converting.dataFromBase64(base64)
        }

        return try Certificate(data: certData)
    }

    var certBegin: String {
        return "-----BEGIN CERTIFICATE-----"
    }
    var certEnd: String {
        return "-----END CERTIFICATE-----"
    }
}
