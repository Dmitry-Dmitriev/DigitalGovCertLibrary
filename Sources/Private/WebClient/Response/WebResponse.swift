import Foundation

protocol WebResponse {
    var requestProvider: WebRequestProvider { get }
    var statusCode: Int? { get }
    var result: Result<Data?, Error> { get }
    var headers: [String: String] { get }
}
