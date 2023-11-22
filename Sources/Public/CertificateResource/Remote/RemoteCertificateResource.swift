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

/// Certificate resource that can be loaded from network
@objc open class RemoteCertificateResource: NSObject, WebRequestProvider, CertificateLoadableResource {
    let urlString: String

    /// Designated initializer
    /// - Parameters:
    ///    - urlString: string representation of remote url
    public init(urlString: String) {
        self.urlString = urlString
        super.init()
    }

    /// Certiicate resource remote url
    @objc
    open func resourceURL() throws -> URL {
        guard let url = URL(string: urlString) else {
            throw DGError.Converting.urlFromString(urlString)
        }
        return url
    }

    /// Tries to create request 
    @objc
    open func makeRequest() throws -> URLRequest {
        let url = try resourceURL()
        return URLRequest(url: url)
    }

    /// URLRequest ro remote certificate resource
    open var request: URLRequest {
        get throws {
            do {
                return try makeRequest()
            } catch {
                let error = DGError.Network.request(self, error: error)
                throw error.dgError
            }
        }
    }

    /// Certificate loader of remote resource
    open var certificateLoader: CertificateLoader {
        return RemoteCertificateLoader(resource: self)
    }
}
