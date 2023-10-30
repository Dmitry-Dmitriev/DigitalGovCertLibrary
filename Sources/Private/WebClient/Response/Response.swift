
import Foundation

struct Response<T> {
    let statusCode: Int?
    let result: Result<T, Error>
    let headers: [String: String]

    init(statusCode: Int? = nil,
         result: Result<T, Error>,
         headers: [String: String] = [:]) {
        self.statusCode = statusCode
        self.result = result
        self.headers = headers
    }
    
    init(data: T,
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

        self.init(statusCode: httpStatusCode,
                  result: result,
                  headers: headers)
    }
}

extension Response: WebResponse where T == Data? {}
