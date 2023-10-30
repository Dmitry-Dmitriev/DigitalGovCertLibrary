
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
            send(request: request, completion: completion)
        }
        catch {
            session.delegateQueue.addOperation {
                let response = Response<Data?>(result: .failure(error))
                completion(response)
            }
        }
    }
    
    private func send(request: URLRequest,
                      completion: @escaping (WebResponse) -> Void) {
        session.dataTask(with: request) { data, response, error in
            let response = Response(data: data, error: error, response: response)
            completion(response)
        }.resume()
    }
}
