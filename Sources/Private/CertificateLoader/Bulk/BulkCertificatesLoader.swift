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

final class BulkCertificatesLoader: Loader {
    private let resources: [CertificateLoadableResource]

    convenience init(fileResources: [FileCertificateResource]) {
        self.init(resources: fileResources)
    }

    convenience init(remoteResources: [RemoteCertificateResource]) {
        self.init(resources: remoteResources)
    }

    private init(resources: [CertificateLoadableResource]) {
        self.resources = resources
    }

    func load(completion: @escaping (BulkLoadResult) -> Void) {
        let group = DispatchGroup()
        let synchronizedQueue = DispatchQueue.serial
        let workQueue = DispatchQueue.concurrent

        var array = [Certificate]()
        var failResources: [BulkErrorLoadItem] = []

        resources.forEach { resource in
            let certificateLoader = OnQueueCertificateLoader(queue: workQueue,
                                                             makeClosure: resource.certificateLoader)
            group.enter()
            certificateLoader.load { result in
                do {
                    let cert = try result.get()
                    synchronizedQueue.async {
                        array.append(cert)
                        group.leave()
                    }
                } catch {
                    let item = BulkErrorLoadItem(certificateResource: resource, error: error)
                    synchronizedQueue.async {
                        failResources.append(item)
                        group.leave()
                    }
                }
            }
        }

        group.notify(queue: synchronizedQueue) {
            let result = BulkLoadResult(certs: array,
                                        failResources: failResources)
            completion(result)
        }
    }
}
