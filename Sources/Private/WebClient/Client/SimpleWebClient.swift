import Foundation

final class SimpleWebClient: WebClient {
    // swiftlint:disable:next large_tuple
    private typealias DataTaskTuple = (Data?, URLResponse?, Error?)
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send(requestProvider: WebRequestProvider,
              completion: @escaping (WebResponse) -> Void) {
        do {
            let request = try requestProvider.request
            send(request: request) { data, response, error in
                let response = Response<Data?>(requestProvider: requestProvider,
                                               data: data,
                                               error: error,
                                               response: response)
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
                      completion: @escaping (DataTaskTuple) -> Void) {
        session.dataTask(with: request) { data, response, error in
            completion((data, response, error))
        }.resume()
    }
}
