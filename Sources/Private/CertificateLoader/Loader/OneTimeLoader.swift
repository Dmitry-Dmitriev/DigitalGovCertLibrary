//  DigitalGovCertLibrary

//  Copyright (c) 2023-Present DigitalGovCertLibrary Team - https://github.com/myTargetSDK/DigitalGovCertLibrary-iOS
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
