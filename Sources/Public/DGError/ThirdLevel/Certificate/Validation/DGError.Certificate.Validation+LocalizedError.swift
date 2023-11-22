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

extension DGError.Certificate.Validation: LocalizedError {
    /// localized error description
    public var errorDescription: String? {
        switch self {
        case .error:
            localizedMessage(key: .dgerrorCode321DescriptionKey)
        case .status:
            localizedMessage(key: .dgerrorCode322DescriptionKey)
        }
    }
    /// localized error failure reason
    public var failureReason: String? {
        switch self {
        case let .error(error):
            return localizedMessage(key: .dgerrorCode321FailureReasonKey, args: [String(error)])
        case let .status(status, secResult: secResult):
            return localizedMessage(key: .dgerrorCode322FailureReasonKey, args: [String(status), String(secResult)])
        }
    }
    /// localized error failure recovery suggestion
    public var recoverySuggestion: String? {
        switch self {
        case .error:
            localizedMessage(key: .dgerrorCode321RecoverySuggestionKey)
        case .status:
            localizedMessage(key: .dgerrorCode322RecoverySuggestionKey)
        }

    }
}

private extension String {
    static let dgerrorCode321DescriptionKey = "dgerror.certificate.validation.error.code.321.description"
    static let dgerrorCode321FailureReasonKey = "dgerror.certificate.validation.error.code.321.failureReason"
    static let dgerrorCode321RecoverySuggestionKey = "dgerror.certificate.validation.error.code.321.recoverySuggestion"

    static let dgerrorCode322DescriptionKey = "dgerror.certificate.validation.status.code.322.description"
    static let dgerrorCode322FailureReasonKey = "dgerror.certificate.validation.status.code.322.failureReason"
    static let dgerrorCode322RecoverySuggestionKey = "dgerror.certificate.validation.status.code.322.recoverySuggestion"
}
