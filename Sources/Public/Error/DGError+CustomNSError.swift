//
//  DGError+CustomNSError.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

// MARK: - CustomNSError
extension DGError: CustomNSError {
    public static var errorDomain: String { return
        String(Self.self)
    }

    public var errorCode: Int {
        switch self {
        case .missingFile: return 1
        case .certDecoding: return 2
        case .certReading: return 3
        }
    }

    public var errorUserInfo: [String: Any] {
        var errorUserInfo = [String: Any]()
        if let errorDescription {
            errorUserInfo[NSLocalizedDescriptionKey] = errorDescription
        }
        if let failureReason {
            errorUserInfo[NSLocalizedFailureReasonErrorKey] = failureReason
        }
        if let recoverySuggestion {
            errorUserInfo[NSLocalizedRecoverySuggestionErrorKey] = recoverySuggestion
        }
        return errorUserInfo
    }
}
