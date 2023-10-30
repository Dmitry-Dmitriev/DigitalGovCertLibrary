

import Foundation

final class LoadingManager<T: ManagableLoader> {
    private let synchronizedQueue = DispatchQueue.serial
    private var loadingStatus: LoadingStatus = .notStarted
    private var loadingResult: T.Output!
    private var completions: [(T.Output) -> Void] = []
    private let loader: T
    
    init(loader: T) {
        self.loader = loader
    }
    
    func load(completion: @escaping (T.Output) -> Void) {
        onSynchronizedQueue { [weak self] in
            self?.start(completion: completion)
        }
    }
    
    private func onSynchronizedQueue(block: @escaping () -> Void) {
        synchronizedQueue.async(execute: block)
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
            self?.onSynchronizedQueue {
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
