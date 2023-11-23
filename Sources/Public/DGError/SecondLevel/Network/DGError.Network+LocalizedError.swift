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

extension DGError.Network: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case let .request(requestProvider, error: _):
            if let request = try? requestProvider.request {
                return localizedMessage(key: .dgerrorCode210DescriptionOption1Key, args: [String(request)])
            } else {
                return localizedMessage(key: .dgerrorCode210DescriptionOption2Key, args: [String(requestProvider)])
            }
        case let .response(error):
            return error.errorDescription
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .request(_, error: error):
            return localizedMessage(key: .dgerrorCode210FailureReasonKey, args: [String(error)])
        case let .response(error):
            return error.failureReason
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case let .request(_, error: error):
            return localizedMessage(key: .dgerrorCode210RecoverySuggestionKey, args: [String(error)])
        case let .response(error):
            return error.recoverySuggestion
        }
    }
}

private extension String {
    static let dgerrorCode210DescriptionOption1Key = "dgerror.network.request.code.210.description.option1"
    static let dgerrorCode210DescriptionOption2Key = "dgerror.network.request.code.210.description.option2"
    static let dgerrorCode210FailureReasonKey = "dgerror.network.request.code.210.failureReason"
    static let dgerrorCode210RecoverySuggestionKey = "dgerror.network.request.code.210.recoverySuggestion"
}
