
import Foundation

protocol WebRequestProvider {
    var request: URLRequest { get throws }
}

extension URLRequest: WebRequestProvider {
    var request: URLRequest {
        get throws {
            return self
        }
    }
}
