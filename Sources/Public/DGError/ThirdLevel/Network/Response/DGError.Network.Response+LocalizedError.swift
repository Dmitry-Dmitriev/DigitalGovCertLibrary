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

extension DGError.Network.Response: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case let .unexpected(type):
            localizedMessage(key: .dgerrorCode221DescriptionKey, args: [type])
        case let .error(error):
            localizedMessage(key: .dgerror222DescriptionKey, args: [String(error)])
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case .unexpected:
            localizedMessage(key: .dgerrorCode221FailureReasonKey)
        case let .error(error):
            localizedMessage(key: .dgerrorCode222FailureReasonKey, args: [String(error)])
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case let .unexpected(type):
            localizedMessage(key: .dgerrorCode221RecoverySuggestionKey, args: [type])
        case let .error(error):
            localizedMessage(key: .dgerrorCode222RecoverySuggestionKey, args: [String(error)])
        }
    }
}

private extension String {
    static let dgerrorCode221DescriptionKey = "dgerror.network.response.code.221.description"
    static let dgerrorCode221FailureReasonKey = "dgerror.network.response.code.221.failureReason"
    static let dgerrorCode221RecoverySuggestionKey = "dgerror.network.response.code.221.recoverySuggestion"

    static let dgerror222DescriptionKey = "dgerror.network.response.code.222.description"
    static let dgerrorCode222FailureReasonKey = "dgerror.network.response.code.222.failureReason"
    static let dgerrorCode222RecoverySuggestionKey = "dgerror.network.response.code.222.recoverySuggestion"
}
