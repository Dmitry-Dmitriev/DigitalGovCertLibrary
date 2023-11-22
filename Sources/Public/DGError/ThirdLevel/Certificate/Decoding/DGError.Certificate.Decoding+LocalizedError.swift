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

extension DGError.Certificate.Decoding: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case let .pem(error):
            return localizedMessage(key: .dgerrorCode331DescriptionKey, args: [String(error)])
        case let .der(error):
            return localizedMessage(key: .dgerrorCode332DescriptionKey, args: [String(error)])
        case .universal:
            return localizedMessage(key: .dgerrorCode333DescriptionKey)
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .pem(error):
            return localizedMessage(key: .dgerrorCode331FailureReasonKey, args: [String(error)])
        case let .der(error):
            return localizedMessage(key: .dgerrorCode332FailureReasonKey, args: [String(error)])
        case let .universal(results):
            let reasons = results.compactMap { result in
                if case let .failure(error) = result {
                    return String(error)
                }
                return nil
            }
            return localizedMessage(key: .dgerrorCode333FailureReasonKey, args: reasons)
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case let .pem(error):
            return localizedMessage(key: .dgerrorCode331RecoverySuggestionKey, args: [String(error)])
        case let .der(error):
            return localizedMessage(key: .dgerrorCode332RecoverySuggestionKey, args: [String(error)])
        case let .universal(results):
            let reasons = results.compactMap { result in
                if case let .failure(error) = result {
                    return String(error)
                }
                return nil
            }
            return localizedMessage(key: .dgerrorCode333FailureReasonKey, args: reasons)
        }
    }
}

private extension String {
    static let dgerrorCode331DescriptionKey = "dgerror.certificate.decoding.pem.code.331.description"
    static let dgerrorCode331FailureReasonKey = "dgerror.certificate.decoding.pem.code.331.failureReason"
    static let dgerrorCode331RecoverySuggestionKey = "dgerror.certificate.decoding.pem.code.331.recoverySuggestion"

    static let dgerrorCode332DescriptionKey = "dgerror.certificate.decoding.der.code.332.description"
    static let dgerrorCode332FailureReasonKey = "dgerror.certificate.decoding.der.code.332.failureReason"
    static let dgerrorCode332RecoverySuggestionKey = "dgerror.certificate.decoding.der.code.332.recoverySuggestion"

    static let dgerrorCode333DescriptionKey = "dgerror.certificate.decoding.universal.code.333.description"
    static let dgerrorCode333FailureReasonKey = "dgerror.certificate.decoding.universal.code.333.failureReason"
    static let dgerrorCode333RecoverySuggestionKey = "dgerror.certificate.decoding.universal.code.333.recoverySuggestion"
}
