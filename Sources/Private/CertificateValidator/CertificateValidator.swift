//
//  DigitalGovCertificateValidator.swift
//  rus.cert-support
//
//  Created by dmitry.dmitriev on 03.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

final class CertificateValidator {
    private let secTrustValidator: SecTrustValidator

    init(certificates: [Certificate]) {
        self.secTrustValidator = SecTrustValidator(certificates: certificates)
    }

    func checkValidity(challenge: URLAuthenticationChallenge,
                       completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let trust = challenge.protectionSpace.serverTrust else {
            completionHandler(.performDefaultHandling, nil)
            return
        }

        let isTrusted = secTrustValidator.checkValidity(of: trust)
        let authChallengeDisposition: URLSession.AuthChallengeDisposition = isTrusted ? .useCredential : .performDefaultHandling
        let credentials: URLCredential? = isTrusted ? .init(trust: trust) : nil

        completionHandler(authChallengeDisposition, credentials)
    }
}
