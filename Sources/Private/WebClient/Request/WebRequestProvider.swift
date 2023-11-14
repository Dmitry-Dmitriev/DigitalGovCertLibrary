import Foundation

public protocol WebRequestProvider {
    var request: URLRequest { get throws }
}
