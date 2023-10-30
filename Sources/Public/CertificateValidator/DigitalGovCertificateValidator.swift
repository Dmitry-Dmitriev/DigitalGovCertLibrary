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

//    @available(iOS 13.0, *)
//    @available(OSX 10.15, *)
//    @objc(checkValidityWithChallenge: completionHandler:)
//    public func checkValidity(challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
//        return await withCheckedContinuation { continuation in
//            checkValidity(challenge: challenge) { disposition, credentials in
//                continuation.resume(returning: (disposition, credentials))
//            }
//        }
//        return await certificateValidator.checkValidity(challenge: challenge)
//    }
}

@available(iOS 13.0, *)
final class Tet: NSObject, URLSessionDelegate {
//    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
//        return await DigitalGovCertificateValidator.shared.checkValidity(challenge: challenge)
//    }
    
//    func urlSession1(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        Task.detached { [weak self] in
//            let result = await self?.urlSession(session, didReceive: challenge)
//            let disposition = result?.0 ?? .performDefaultHandling
//            let credentials = result?.1
//            completionHandler(disposition, credentials)
//        }
//    }
}
