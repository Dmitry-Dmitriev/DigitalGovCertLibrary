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

final class FileCertificateLoader: CertificateLoader {
    let resource: FileCertificateResource

    init(resource: FileCertificateResource) {
        self.resource = resource
    }

    private let workingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.underlyingQueue = DispatchQueue.concurrent
        return queue
    }()

    func load(completion: @escaping (Result<Certificate, Error>) -> Void) {
        do {
            let url = try resource.resourceURL()
            let coordinator = NSFileCoordinator()
            let intent = NSFileAccessIntent.readingIntent(with: url)
            coordinator.coordinate(with: [intent],
                                   queue: workingQueue) { fileError in
                if let fileError {
                    let fileName = intent.url.fileName
                    let filePath = intent.url.filePath
                    let reason = fileError.localizedDescription
                    let wrappedError = DGError.File.reading(name: fileName, atPath: filePath, reason: reason)
                        .dgError
                    completion(.failure(wrappedError))
                    return
                }

                let reader: CertificateReader = FileURLCertificateReader(url: intent.url)
                let cert = reader.readCertificateResult()
                completion(cert)
            }
        } catch {
            completion(.failure(error))
        }
    }
}
