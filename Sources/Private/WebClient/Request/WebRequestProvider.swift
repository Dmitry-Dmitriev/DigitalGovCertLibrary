import Foundation

/// Any object that provides request
public protocol WebRequestProvider {
    /// Request itself
    var request: URLRequest { get throws }
}
