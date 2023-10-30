//
//  CertificateFile.swift
//  digital.gov.rus.cert.support
//
//  Created by dmitry.dmitriev on 10.10.2023.
//  Copyright © 2023 VK. All rights reserved.
//

import Foundation

@objc public protocol CertificateResource: NSObjectProtocol {
    func makeURL() throws -> URL
}

protocol LoaderProvider {
    func loader(with queue: DispatchQueue) -> Loader
}

final class FileCertificateResource: NSObject, CertificateResource & LoaderProvider {
    let certBundle: Bundle
    let certName: String
    let certExtension: CertExtension
    
    init(certBundle: Bundle, certName: String, certExtension: CertExtension) {
        self.certBundle = certBundle
        self.certName = certName
        self.certExtension = certExtension
    }
    
    func makeURL() throws -> URL {   
        guard let certUrl = certBundle.url(forResource: certName, withExtension: certExtension.string)
        else { throw missingFileError }
        return certUrl
    }
    
    var missingFileError: DGError {
        DGError.missingFile(name: fullFileName, atPath: fileLocation)
    }
    var decodingFileError: DGError {
        DGError.certDecoding(name: fullFileName,
                                   atPath: fileLocation)

    }
    func readingFileError(reason: String) -> DGError {
        DGError.certReading(name: fullFileName, atPath: fileLocation, reason: reason)
    }

    var fullFileName: String {
        certName + .dot + certExtension.string
    }

    var fileLocation: String {
        certBundle.bundlePath
    }
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(certBundle)
        hasher.combine(certName)
        hasher.combine(certExtension)
        return hasher.finalize()
    }
    
    func loader(with queue: DispatchQueue) -> Loader {
        return Worker(queue: queue, closure: FileLoader(resource: self))
    }
    
}

extension Array where Element == FileCertificateResource {
    private static let digitalGovCertificateNames = ["russiantrustedrootca", "russiantrustedsubca"]
    static let digitalGov: [FileCertificateResource] = {
        digitalGovCertificateNames.map { name in
            FileCertificateResource(certBundle: .resourcesBundle, certName: name, certExtension: .cer)
        }
    }()
}




final class RemoteCertificateResource: NSObject, CertificateResource, WebRequestProvider, LoaderProvider {
    // https://gu-st.ru/content/Other/doc/russiantrustedca.pem
    let urlString: String
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func makeURL() throws -> URL {
        guard let url = URL(string: urlString) else {
            throw DGError.certDecoding(name: .empty, atPath: .empty)
        }
        return url
    }
    
    func makeRequest() throws -> URLRequest {
        return try URLRequest(url: makeURL())
    }
    
    var request: URLRequest {
        get throws {
            try makeRequest()
        }
    } 
    
    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(urlString)
        return hasher.finalize()
    }
    
    func loader(with queue: DispatchQueue) -> Loader {
        return Worker(queue: queue, closure: RemoteLoader(resource: self))
    }
}

extension Array where Element == RemoteCertificateResource {
    private static let certURLs = [
        "https://gu-st.ru/content/Other/doc/russiantrustedca.pem"
    ]
    
    static let digitalGov: [RemoteCertificateResource] = {
        certURLs.map { urlString in
            RemoteCertificateResource(urlString: urlString)
        }
    }()
}


/// no docs
@objc public final class CertificateFile: NSObject {
    public let certBundle: Bundle
    public let certName: String
    public let certExtension: CertExtension
    public let certDecoder: CertFormatDecoder

    /// no docs
    @objc public init(name: String,
                      extension: CertExtension,
                      bundle: Bundle,
                      certDecoder: CertFormatDecoder = UniversalCertDecoder()) {
        self.certName = name
        self.certExtension = `extension`
        self.certBundle = bundle
        self.certDecoder = certDecoder
        super.init()
    }

    @objc public func loadCerificate() throws -> Certificate {
        let certificate = try certDecoder.decode(certificateFile: self)
        return certificate
    }
}

