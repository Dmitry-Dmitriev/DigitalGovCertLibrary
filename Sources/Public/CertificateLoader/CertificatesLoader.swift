//
//  CertificatesLoader.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 03.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

@objc public protocol CertificatesLoader: NSObjectProtocol {
    func loadCertificates() throws -> [Certificate]
}


@objc public protocol CertificateLoaderNew: NSObjectProtocol {
    func load(certificates: [CertificateResource]) async throws -> [Certificate]
}

protocol CertificateLoaderTwo {
    associatedtype Certificates: CertificateResource
    func load(certificates: [Certificates], completion: @escaping (Result<[Certificate], Error>) -> Void)
}

protocol CertificateLoaderThree {
    func load(resource: CertificateResource,
              completion: @escaping (Result<Certificate, Error>) -> Void)
}


final class FileLoader: Loader {
    let resource: FileCertificateResource
    init(resource: FileCertificateResource) {
        self.resource = resource
    }
    
    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        do {
            let url = try resource.makeURL()
            let data = try Data(contentsOf: url)
            let decoder = UniversalCertDecoder()
            let cert = try decoder.decode(certificateData: data)
            completion(.success(cert))
        }
        catch {
            completion(.failure(error))
        }
    }
}

struct BulkErrorLoadItem {
    let certificateResource: CertificateResource
    let error: Error
}

struct BulkLoadResult: LoadingItem {
    let certs: [Certificate]
    let failResources: [BulkErrorLoadItem]
    
    var isFailed: Bool {
        !failResources.isEmpty
    }
}

final class LoadingManager<T: ManagableLoader> {
    let workQueue = DispatchQueue(label: "")
    private var loadingStatus: LoadingStatus = .notStarted
    private var loadingResult: T.Output!
    private var completions: [(T.Output) -> Void] = []
    private let loader: T
    
    init(loader: T) {
        self.loader = loader
    }
    
    func load(completion: @escaping (T.Output) -> Void) {
        onWorkQueue { [weak self] in
            self?.start(completion: completion)
        }
    }
    
    private func onWorkQueue(block: @escaping () -> Void) {
        workQueue.async(execute: block)
    }

    private func start(completion: @escaping (T.Output) -> Void) {
        completions.append(completion)
        
        if loadingStatus == .loading {
            return
        }
        
        if loadingStatus == .finished {
            complete()
            return
        }
        
        loadingStatus = .loading
        loader.load { [weak self] result in
            self?.onWorkQueue {
                self?.finish(result: result)
            }
        }
    }

    private func finish(result: T.Output) {
        loadingStatus = result.isFailed ? .notStarted: .finished
        loadingResult = result
        complete()
    }

    private func complete() {
        completions.forEach { completion in
            completion(loadingResult)
        }
        completions.removeAll()
    }
}

enum LoadingStatus {
    case notStarted
    case loading
    case finished
}

protocol LoadingItem {
    var isFailed: Bool { get }
}

protocol ManagableLoader {
    associatedtype Output: LoadingItem
    func load(completion: @escaping (Output) -> Void)
}

final class BulkLoader: ManagableLoader {
    private let resources: [CertificateResource & LoaderProvider]
    
    convenience init(fileResources: [FileCertificateResource]) {
        self.init(resources: fileResources)
    }
    
    convenience init(remoteResources: [RemoteCertificateResource]) {
        self.init(resources: remoteResources)
    }
    
    private init(resources: [CertificateResource & LoaderProvider]) {
        self.resources = resources
    }

    func load(completion: @escaping (BulkLoadResult) -> Void) {
        let group = DispatchGroup()
        let syncqueue = DispatchQueue(label: "")
        let workQueue = DispatchQueue(label: "")
        
        var array = [Certificate]()
        var failResources: [BulkErrorLoadItem] = []
       
        resources.forEach { resource in
            let loader = resource.loader(with: workQueue)
            group.enter()
            loader.load { result in
                do {
                    let cert = try result.get()
                    syncqueue.async {
                        array.append(cert)
                    }
                }
                catch {
                    let item = BulkErrorLoadItem(certificateResource: resource, error: error)
                    syncqueue.async {
                        failResources.append(item)
                    }
                }
                group.leave()
            }
        }

        group.notify(queue: syncqueue) {
            let result = BulkLoadResult(certs: array,
                                        failResources: failResources)
            completion(result)
        }
    }
}

public protocol Loader {
    func load(completion: @escaping (Result<Certificate, Error>) -> Void)
}

final class Worker: Loader {
    private let makeloader: () -> Loader
    private let queue: DispatchQueue
    
    init(queue: DispatchQueue, closure: @autoclosure @escaping () -> Loader) {
        self.makeloader = closure
        self.queue = queue
    }
    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        let loader = makeloader()
        queue.async {
            loader.load(completion: completion)
        }
    }
}

final class RemoteLoader: Loader {
    private let remoteResource: RemoteCertificateResource
    private let client: WebClient = SimpleWebClient()
    
    init(resource: RemoteCertificateResource) {
        self.remoteResource = resource
    }
    
    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        client.send(requestProvider: remoteResource) { response in
            completion(response.result)
        }
    }
}

@objc public final class FileCertificateLoader: NSObject, CertificateLoaderNew, CertificateLoaderTwo {
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.underlyingQueue = .global(qos: .utility)
        return queue
    }()
    
    func load(certificates: [FileCertificateResource],
              completion: @escaping (Result<[Certificate], Error>) -> Void) {
        queue.addOperation {
            var certs = [Certificate]()
            for resource in certificates {
                do {
                    let url = try resource.makeURL()
                    let data = try Data(contentsOf: url)
                    let decoder = UniversalCertDecoder()
                    let cert = try decoder.decode(certificateData: data)
                    certs.append(cert)
                }
                catch {
                    completion(.failure(error))
                    break
                }
            }
            completion(.success(certs))
        }
    }
        
    
//    @available(iOS 13, *)
//    @available(OSX 10.15, *)
    public func load(certificates: [CertificateResource]) async throws -> [Certificate] {
        let urls = try certificates.map { url in try url.makeURL() }
        if #available(iOS 13, *), #available(macOS 10.15, *) {
            return try await urls.concurrentMap { [self] url in
                let coordinator = NSFileCoordinator()
                let intent = NSFileAccessIntent.readingIntent(with: url)
                let data = try await coordinator.coordinate(with: intent, queue: self.queue)
                let decoder = UniversalCertDecoder()
                let cert = try decoder.decode(certificateData: data)
                return cert
            }
        } else {
            return try urls.map { url in
                let data = try Data(contentsOf: url)
                let decoder = UniversalCertDecoder()
                let cert = try decoder.decode(certificateData: data)
                return cert
            }
        }
    }
}

@objc public final class RemoteCertificateLoader: NSObject, CertificateLoaderNew, CertificateLoaderTwo {
    
    public func load(certificates: [CertificateResource]) async throws -> [Certificate] {
        let urls = try certificates.map { url in try url.makeURL() }
        if #available(iOS 13, *), #available(macOS 10.15, *) {
            return try await urls.asyncMap { url in
                try await load(url: url)
            }
        } else {
            return try urls.map { url in
                let data = try Data(contentsOf: url)
                let decoder = UniversalCertDecoder()
                let cert = try decoder.decode(certificateData: data)
                return cert
            }
        }
    }
    
    @available(iOS 13, *)
    @available(OSX 10.15, *)
    func load(url: URL) async throws -> Certificate {
        let data = try Certificate(data: Data())
        Task { await storage.add(certifiacte: data) }
        return try await Task.detached { [self] in
                return try self.load(url: url)
            }.value
    }
    
    func load(url: URL) throws -> Certificate {
        let data = try Data(contentsOf: url)
        return try Certificate(data: data)
    }
    
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.underlyingQueue = .global(qos: .utility)
        return queue
    }()
    
    private let webClient: WebClient = SimpleWebClient()
    private let storage: CertificateStorage = InMemmoryCertificateStorage()
    
    func load(certificates: [RemoteCertificateResource],
              completion: @escaping (Result<[Certificate], Error>) -> Void) {
        
            var certs = [Certificate]()
            for resource in certificates {
                do {
                    let request = try resource.makeRequest()
                    webClient.send(requestProvider: request) { (response: Response<[Certificate]>)
                                                                     in
                        let decoder = UniversalCertDecoder()
                        
//                        switch response.result {
//                        case .success(let success):
//                            DGError.Network.request(request, error: DGError.Network.Response.unexpected)
//                        case .failure(let failure):
//                            <#code#>
//                        }
//                        guard error == nil,
//                           let httpResponse = response as? HTTPURLResponse,
//                           httpResponse.statusCode / 100 == 2,
//                              let data,
//                              let cert = try? decoder.decode(certificateData: data)
//                        else {
//                            self?.queue.addOperation {
//                                completion(.failure(DGError.certDecoding(name: .empty, atPath: .empty)))
//                            }
//                            return
//                        }
//                        self?.queue.addOperation {
//                            certs.append(cert)
//                            if certs.count == certificates.count {
//                                completion(.success(certs))
//                            }
                        }
                }
                catch {
                    completion(.failure(error))
                    break
                }
            }
    }
}
protocol CertificateStorage {
    var all: [Certificate] { get async }
    func remove(certifiacte: Certificate) async
    func add(certifiacte: Certificate) async
}

actor InMemmoryCertificateStorage: CertificateStorage {
    private(set) var storage: [Certificate] = []

    var all: [Certificate] {
        get async {
            return storage
        }
    }
    
    func remove(certifiacte: Certificate) async {
        storage.removeAll { cert in
            cert.certificate == certifiacte.certificate
        }
    }
    
    func add(certifiacte: Certificate) async {
        storage.append(certifiacte)
    }
}


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

protocol WebResponse {
    var statusCode: Int? { get }
    var result: Result<Data?, Error> { get }
    var headers: [String: String] { get }
}


struct Response<T> {
    let statusCode: Int?
    let result: Result<T, Error>
    let headers: [String: String]

    init(statusCode: Int? = nil,
         result: Result<T, Error>,
         headers: [String: String] = [:]) {
        self.statusCode = statusCode
        self.result = result
        self.headers = headers
    }
    
    init(data: T,
         error: Error?,
         response: URLResponse?) {
        let httpResponse = response as? HTTPURLResponse
        let httpStatusCode = httpResponse?.statusCode
        let httpHeaders = httpResponse?.allHeaderFields ?? [:]
        let tuples = httpHeaders.compactMap { key, value in
            let newKey = String(key)
            let newValue = String(value)
            return (newKey, newValue)
        }
        let headers = Dictionary(uniqueKeysWithValues: tuples)
        let result = Result {
            if let error { throw error }
            return data
        }

        self.init(statusCode: httpStatusCode,
                  result: result,
                  headers: headers)
    }
}


extension Response: WebResponse where T == Data? {}


protocol WebClient {
    func send(requestProvider: WebRequestProvider,
              completion: @escaping (WebResponse) -> Void)
}

extension Result {
    var void: Result<Void, Error> {
        switch self {
        case .success: return .success(Void())
        case let .failure(error): return .failure(error)
        }
    }
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

public func checkValidity(challenge: URLAuthenticationChallenge,
                          completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    let file = DGCert(fileCertificates: [])
    file.checkValidity(challenge: <#T##URLAuthenticationChallenge#>,
                         completionHandler: <#T##(URLSession.AuthChallengeDisposition, URLCredential?) -> Void#>)
    
    let remote = DGCert(remoteCertificates: [])
    remote.checkValidity(challenge: <#T##URLAuthenticationChallenge#>,
                         completionHandler: <#T##(URLSession.AuthChallengeDisposition, URLCredential?) -> Void#>)
    
    
    DGCert.shared.checkValidity(challenge: challenge, completionHandler: completionHandler)
    
}

final class DGCert {
    
    private let loader: LoadingManager<BulkLoader>
    private lazy var validator = CertificateValidator(certificates: [])

    let shared = DGCert(fileCertificates: .digitalGov)

    convenience init(fileCertificates: [FileCertificateResource]) {
        let bulkLoader = BulkLoader(fileResources: fileCertificates)
        self.init(loader: bulkLoader)
    }
    
    convenience init(remoteCertificates: [RemoteCertificateResource]) {
        let bulkLoader = BulkLoader(remoteResources: remoteCertificates)
        self.init(loader: bulkLoader)
    }
    
    private init(loader: BulkLoader) {
        self.loader = LoadingManager(loader: loader)
    }
    func load() {
        loader.load { _ in }
    }
    
    public func checkValidity(challenge: URLAuthenticationChallenge,
                              completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
       
        loader.load { result in
            if result.isFailed {
                completionHandler(.performDefaultHandling, nil)
                return
            } else {
                let validator = CertificateValidator(certificates: result.certs)
                validator.checkValidity(challenge: challenge, completionHandler: completionHandler)
            }
        }
    }
}

extension NSFileCoordinator {
    @available(iOS 13, *)
    @available(OSX 10.15, *)
    func coordinate(with intent: NSFileAccessIntent, queue: OperationQueue) async throws -> Data  {
        return try await withCheckedThrowingContinuation { continuation in
            coordinate(with: [intent], queue: queue) { error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                let result = Result {
                    try Data(contentsOf: intent.url)
                }
                continuation.resume(with: result)
            }
        }

//        let intent = NSFileAccessIntent.readingIntent(with: URL(string: "")!)
//        let coordinator = NSFileCoordinator()
//
//        coordinator.coordinate(with: [intent],
//                               queue: queue) { error in
       
    }
    
}


@available(iOS 13, *)
@available(OSX 10.15, *)
extension Sequence {
    func asyncForEach(_ operation: (Element) async throws -> Void) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
    
    func concurrentForEach(_ operation: @escaping (Element) async -> Void) async {
        // A task group automatically waits for all of its
        // sub-tasks to complete, while also performing those
        // tasks in parallel:
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await operation(element)
                }
            }
        }
    }
    
    func concurrentMap<T>(_ transform: @escaping (Element) async throws -> T) async throws -> [T] {
        let tasks = map { element in
            Task {
                try await transform(element)
            }
        }
        
        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
    
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
}
