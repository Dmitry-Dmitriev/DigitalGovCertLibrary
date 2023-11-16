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
