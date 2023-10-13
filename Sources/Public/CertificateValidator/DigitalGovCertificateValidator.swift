//
//  DigitalGovCertificateValidator.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

@objc(DGCertificateValidator)
public final class DigitalGovCertificateValidator: NSObject, URLAuthenticationChallengeValidator {
    @objc public static let shared = DigitalGovCertificateValidator(certLoader: .digitalGov)

    private let certificateValidator: CertificateValidator
    private let digitalGovCertContainer: DigitalGovCertificateContainer

    @objc(initWithCertLoader:)
    public init(certLoader: BulkCertificatesLoader) {
        digitalGovCertContainer = .init(digitalGovCertLoader: certLoader)
        certificateValidator = .init(certificates: digitalGovCertContainer.certificates)
        super.init()
    }

    @objc(checkValidityWithChallenge: completionHandler:)
    public func checkValidity(challenge: URLAuthenticationChallenge,
                              completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        certificateValidator.checkValidity(challenge: challenge, completionHandler: completionHandler)
    }

    @available(iOS 13, *)
    @available(OSX 10.15, *)
    func loadItems(challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        return await withCheckedContinuation { continuation in
            checkValidity(challenge: challenge) { disposition, credentials in
                continuation.resume(returning: (disposition, credentials))
            }
        }
    }
}

final class Tet: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        guard let trust = challenge.protectionSpace.serverTrust else {
            return (.performDefaultHandling, nil)
        }

        let isTrusted = "test" == "test1" ? true : false
        let authChallengeDisposition: URLSession.AuthChallengeDisposition = isTrusted ? .useCredential : .performDefaultHandling
        let credentials: URLCredential? = isTrusted ? .init(trust: trust) : nil

        return (authChallengeDisposition, credentials)
    }
}
