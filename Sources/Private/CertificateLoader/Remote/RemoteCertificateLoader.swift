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

final class RemoteCertificateLoader: CertificateLoader {
    private let remoteResource: RemoteCertificateResource
    private let client: WebClient = SimpleWebClient()

    init(resource: RemoteCertificateResource) {
        self.remoteResource = resource
    }

    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        client.send(requestProvider: remoteResource) { response in
            do {
                guard let data = try response.result.get() else {
                    throw DGError.Network.Response.unexpected(type: String(Certificate.self))
                }
                let universalDecoder: CertificateDecoder = UniversalCertDecoder()
                let cert = try universalDecoder.decode(certificateData: data)
                completion(.success(cert))
            } catch {
                let error = DGError.Network.response(error: .error(error)).dgError
                completion(.failure(error))
            }
        }
    }
}
