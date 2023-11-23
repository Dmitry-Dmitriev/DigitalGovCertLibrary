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

final class SimpleWebClient: WebClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send(requestProvider: WebRequestProvider,
              completion: @escaping (WebResponse) -> Void) {
        do {
            let request = try requestProvider.request
            send(request: request) { dataTaskResponse in
                let response = Response<Data?>(requestProvider: requestProvider,
                                               data: dataTaskResponse.data,
                                               error: dataTaskResponse.error,
                                               response: dataTaskResponse.response)
                completion(response)
            }
        } catch {
            session.delegateQueue.addOperation {
                let response = Response<Data?>(requestProvider: requestProvider,
                                               result: .failure(error))
                completion(response)
            }
        }
    }

    private func send(request: URLRequest,
                      completion: @escaping (DataTaskResponse) -> Void) {
        session.dataTask(with: request) { data, response, error in
            let dataTaskResponse = DataTaskResponse(data: data,
                                                    response: response,
                                                    error: error)
            completion(dataTaskResponse)
        }.resume()
    }
}

private extension SimpleWebClient {
    struct DataTaskResponse {
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
}
