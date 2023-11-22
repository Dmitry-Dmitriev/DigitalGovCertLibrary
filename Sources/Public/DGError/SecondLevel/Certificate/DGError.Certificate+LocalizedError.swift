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

extension DGError.Certificate: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case .creation:
            return localizedMessage(key: .dgerrorCode310DescriptionKey)
        case let .validation(error):
            return error.errorDescription
        case let .decoding(error):
            return error.errorDescription
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .creation(data: data):
            return localizedMessage(key: .dgerrorCode310FailureReasonKey, args: [String(data)])
        case let .validation(error):
            return error.failureReason
        case let .decoding(error):
            return error.failureReason
        }
    }

    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case .creation:
            return localizedMessage(key: .dgerrorCode310RecoverySuggestionKey)
        case let .validation(error):
            return error.recoverySuggestion
        case let .decoding(error):
            return error.recoverySuggestion
        }
    }
}

private extension String {
    static let dgerrorCode310DescriptionKey = "dgerror.certificate.creation.code.310.description"
    static let dgerrorCode310FailureReasonKey = "dgerror.certificate.creation.code.310.failureReason"
    static let dgerrorCode310RecoverySuggestionKey = "dgerror.certificate.creation.code.310.recoverySuggestion"
}
