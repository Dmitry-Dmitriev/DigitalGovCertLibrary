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
        send(requestProvider: requestProvider) { (response: WebResponse) in
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
                let error = DGError.Network.response(error: .error(error)).dgError
                let newResponse = Response<T>(requestProvider: requestProvider,
                                              statusCode: response.statusCode,
                                              result: .failure(error))
                completion(newResponse)
                let decoder = JSONDecoderBuilder()
                    .add(dataDecodingStrategy: .base64)
                    .add(dateDecodingStrategy: .deferredToDate)
                    .add(nonConformingFloatDecodingStrategy: .throw)
                    .add(userInfo: [:])
                    .finish()
                
                decoder.decode(Data.self, from: Data(), configuration: DecodableWithConfiguration.DecodingConfiguration)
            }
        }
    }
}


final class JSONDecoderBuilder {
    private let decoder = JSONDecoder()
    
    func add(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) -> JSONDecoderBuilder {
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return self
    }

    func add(dataDecodingStrategy: JSONDecoder.DataDecodingStrategy) -> JSONDecoderBuilder {
        decoder.dataDecodingStrategy = dataDecodingStrategy
        return self
    }
    
    func add(nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy) -> JSONDecoderBuilder {
        decoder.nonConformingFloatDecodingStrategy = nonConformingFloatDecodingStrategy
        return self
    }
    
  
    func add(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy) -> JSONDecoderBuilder {
        decoder.keyDecodingStrategy = keyDecodingStrategy
        return self
    }

    func add(userInfo: [CodingUserInfoKey : Any]) -> JSONDecoderBuilder {
        decoder.userInfo = userInfo
        return self
    }

    @available(iOS 15.0, *)
    func add(allowsJSON5: Bool) -> JSONDecoderBuilder {
        decoder.allowsJSON5 = allowsJSON5
        return self
    }
    
    @available(iOS 15.0, *)
    func add(assumesTopLevelDictionary: Bool) -> JSONDecoderBuilder {
        decoder.assumesTopLevelDictionary = assumesTopLevelDictionary
        return self
    }

    func finish() -> JSONDecoder {
        return decoder
    }
}
