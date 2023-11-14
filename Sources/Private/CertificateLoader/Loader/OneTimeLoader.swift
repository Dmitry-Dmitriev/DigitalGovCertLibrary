import Foundation

final class OneTimeLoader<T: Loader> {
    private let synchronizedQueue: DispatchQueue = .serial
    private var loadingStatus: LoadingStatus<T.Output> = .idle
    private var completions: [(T.Output) -> Void] = []
    private let loader: T

    init(loader: T) {
        self.loader = loader
    }

    func load(completion: @escaping (T.Output) -> Void) {
        synchronizedQueue.async { [weak self] in
            self?.start(completion: completion)
        }
    }

    private func start(completion: @escaping (T.Output) -> Void) {
        completions.append(completion)

        switch loadingStatus {
        case .idle:
            startLoading()
        case .loading:
            return
        case .finished(let loadingResult):
            complete(result: loadingResult)
        }
    }

    private func startLoading() {
        loadingStatus = .loading
        loader.load { [weak self] result in
            self?.synchronizedQueue.async {
                self?.finish(result: result)
            }
        }
    }

    private func finish(result: T.Output) {
        loadingStatus = result.isFailed ? .idle : .finished(result: result)
        complete(result: result)
    }

    private func complete(result: T.Output) {
        completions.forEach { completion in
            completion(result)
        }
        completions.removeAll()
    }
}
