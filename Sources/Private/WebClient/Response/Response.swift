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

struct Response<T> {
    let statusCode: Int?
    let result: Result<T, Error>
    let headers: [String: String]
    let requestProvider: WebRequestProvider

    init(requestProvider: WebRequestProvider,
         statusCode: Int? = nil,
         result: Result<T, Error>,
         headers: [String: String] = [:]) {
        self.requestProvider = requestProvider
        self.statusCode = statusCode
        self.result = result
        self.headers = headers
    }

    init(requestProvider: WebRequestProvider,
         data: T,
         error: Error?,
         response: URLResponse?) {
        let httpResponse = response as? HTTPURLResponse
        let httpStatusCode = httpResponse?.statusCode
        let httpHeaders = httpResponse?.allHeaderFields ?? [:]
        let tuples = httpHeaders.compactMap { key, value in
            let newKey = String(key)
            let newValue = String(value)
            return (newKey, newValue)
        }
        let headers = Dictionary(uniqueKeysWithValues: tuples)
        let result = Result {
            if let error { throw error }
            return data
        }

        self.init(requestProvider: requestProvider,
                  statusCode: httpStatusCode,
                  result: result,
                  headers: headers)
    }
}

extension Response: WebResponse where T == Data? {}
