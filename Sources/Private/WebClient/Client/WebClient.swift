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

protocol WebClient: AnyObject {
    func send(requestProvider: WebRequestProvider,
              completion: @escaping (WebResponse) -> Void)
}

extension WebClient {
    func send(requestProvider: WebRequestProvider,
              completion: @escaping (Response<Void>) -> Void) {
        send(requestProvider: requestProvider) { (response: WebResponse) in
            let response = Response<Void>(requestProvider: requestProvider,
                                          statusCode: response.statusCode,
                                          result: response.result.void)
            completion(response)
        }
    }

    func send<T>(requestProvider: WebRequestProvider,
                 completion: @escaping (Response<T>) -> Void) where T: Decodable {
        send(requestProvider: requestProvider) { (response: WebResponse) in
            do {
                guard let data = try response.result.get() else {
                    throw DGError.Network.Response.unexpected(type: String(T.self))
                }
                let decoded = try JSONDecoder().decode(T.self, from: data)
                let newResponse = Response(requestProvider: requestProvider,
                                           statusCode: response.statusCode,
                                           result: .success(decoded))
                completion(newResponse)
            } catch {
                let error = DGError.Network.response(error: .error(error)).dgError
                let newResponse = Response<T>(requestProvider: requestProvider,
                                              statusCode: response.statusCode,
                                              result: .failure(error))
                completion(newResponse)
            }
        }
    }
}
