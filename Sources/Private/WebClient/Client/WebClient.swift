
import Foundation

protocol WebClient: AnyObject {
    func send(requestProvider: WebRequestProvider,
              completion: @escaping (WebResponse) -> Void)
}

extension WebClient {
    func send(requestProvider: WebRequestProvider,
              completion: @escaping (Response<Void>) -> Void) {
        send(requestProvider: requestProvider) { (response: WebResponse) in
            let response = Response<Void>(statusCode: response.statusCode,
                                          result: response.result.void)
            completion(response)
        }
    }
    func send<T>(requestProvider: WebRequestProvider,
                 completion: @escaping (Response<T>) -> Void) where T: Decodable {
        send(requestProvider: requestProvider) { response in
            do {
                guard let data = try response.result.get() else {
                    throw DGError.Network.Response.unexpected
                }
                let decoded = try JSONDecoder().decode(T.self, from: data)
                let newResponse = Response(statusCode: response.statusCode, result: .success(decoded))
                completion(newResponse)
            }
            catch {
                let newResponse = Response<T>(statusCode: response.statusCode, result: .failure(error))
                completion(newResponse)
            }
        }
    }
}

