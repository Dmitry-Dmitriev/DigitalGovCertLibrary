import Foundation

protocol WebClient: AnyObject {
    func send(requestProvider: WebRequestProvider,
              completion: @escaping (WebResponse) -> Void)
}

extension WebClient {
    func send(requestProvider: WebRequestProvider,
              completion: @escaping (Response<Void>) -> Void) {
        send(requestProvider: requestProvider) { (response: WebResponse) in
            let response = Response<Void>(requestProvider: requestProvider,
                                          statusCode: response.statusCode,
                                          result: response.result.void)
            completion(response)
        }
    }

    func send<T>(requestProvider: WebRequestProvider,
                 completion: @escaping (Response<T>) -> Void) where T: Decodable {
        send(requestProvider: requestProvider) { response in
            do {
                guard let data = try response.result.get() else {
                    throw DGError.Network.Response.unexpected(type: String(T.self))
                }
                let decoded = try JSONDecoder().decode(T.self, from: data)
                let newResponse = Response(requestProvider: requestProvider,
                                           statusCode: response.statusCode,
                                           result: .success(decoded))
                completion(newResponse)
            } catch {
                let error = DGError.network(.request(requestProvider, error: error))
                let newResponse = Response<T>(requestProvider: requestProvider,
                                              statusCode: response.statusCode,
                                              result: .failure(error))
                completion(newResponse)
            }
        }
    }
}
