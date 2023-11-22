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

extension DGError.Converting: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .stringFromData:
            return localizedMessage(key: .dgerror10DescriptionKey)
        case .dataFromBase64:
            return localizedMessage(key: .dgerrorCode11DescriptionKey)
        case .urlFromString:
            return localizedMessage(key: .dgerror12DescriptionKey)
        }
    }

    var failureReason: String? {
        switch self {
        case let .stringFromData(data):
            return localizedMessage(key: .dgerror10FailureReasonKey, args: [String(data)])
        case let .dataFromBase64(string):
            return localizedMessage(key: .dgerrorCode11FailureReasonKey, args: [string])
        case let .urlFromString(string):
            return localizedMessage(key: .dgerror12FailureReasonKey, args: [string])
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .stringFromData:
            return localizedMessage(key: .dgerror10RecoverySuggestionKey)
        case .dataFromBase64:
            return localizedMessage(key: .dgerrorCode11RecoverySuggestionKey)
        case .urlFromString:
            return localizedMessage(key: .dgerror12RecoverySuggestionKey)
        }
    }
}

private extension String {
    static let dgerror10DescriptionKey = "dgerror.convering.code.10.description"
    static let dgerror10FailureReasonKey = "dgerror.convering.code.10.failureReason"
    static let dgerror10RecoverySuggestionKey = "dgerror.convering.code.10.recoverySuggestion"

    static let dgerrorCode11DescriptionKey = "dgerror.converting.code.11.description"
    static let dgerrorCode11FailureReasonKey = "dgerror.converting.code.11.failureReason"
    static let dgerrorCode11RecoverySuggestionKey = "dgerror.converting.code.11.recoverySuggestion"

    static let dgerror12DescriptionKey = "dgerror.converting.code.12.description"
    static let dgerror12FailureReasonKey = "dgerror.converting.code.12.failureReason"
    static let dgerror12RecoverySuggestionKey = "dgerror.converting.code.12.recoverySuggestion"
}
