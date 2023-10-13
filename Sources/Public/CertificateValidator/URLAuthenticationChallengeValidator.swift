//
//  URLAuthenticationChallengeValidator.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

@objc public protocol URLAuthenticationChallengeValidator: NSObjectProtocol {
    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
}
