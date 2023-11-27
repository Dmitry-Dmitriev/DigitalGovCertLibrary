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

/// Any object that can validate authenticate challenge
@objc public protocol URLAuthenticationChallengeValidator: NSObjectProtocol {
    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (CertificateValidationResult?) -> Void)

    func checkValidity(_ challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
}

@available(iOS 13.0, *)
@available(OSX 10.15, *)
extension URLAuthenticationChallengeValidator {
    /// Async / await version of checkValidity(challenge: completionHandler: )
    func checkValidity(ofChallenge challenge: URLAuthenticationChallenge) async -> CertificateValidationResult? {
        await withCheckedContinuation { continuation in
            checkValidity(challenge: challenge) { certificateValidationResult in
                continuation.resume(returning: certificateValidationResult)
            }
        }

    }

    /// Async / await version of checkValidity(_ challenge: completionHandler: )
    func checkValidity(_ challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        await withCheckedContinuation { continuation in
            checkValidity(challenge) { disposition, credential in
                continuation.resume(returning: (disposition, credential))
            }
        }
    }
}
