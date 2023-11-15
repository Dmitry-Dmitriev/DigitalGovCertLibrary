import Foundation

protocol PemDecoder {
    func decode(pemData: Data) throws -> Certificate
}

extension PemDecoder {
    func decode(pemData: Data) throws -> Certificate {
        do {
            return try decode(pem: pemData)
        } catch {
            throw DGError.Certificate.Decoding.pem(error).dgError
        }
    }
}

private extension PemDecoder {
    func decode(pem: Data) throws -> Certificate {
        guard let fileContent = String(data: pem, encoding: .utf8) else {
            throw DGError.Converting.stringFromData(pem)
        }

        var base64 = fileContent
            .replacingOccurrences(of: certBegin, with: String.empty)
            .replacingOccurrences(of: certEnd, with: String.empty)

        if #available(iOS 16.0, *), #available(OSX 13.0, *) {
            base64 = base64.split(separator: Character.linebreak).joined()

        } else {
            base64 = base64.components(separatedBy: Character.linebreak).joined()
        }

        guard let certData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) else {
            throw DGError.Converting.dataFromBase64(base64)
        }

        return try Certificate(data: certData)
    }
    
    var certBegin: String {
        return "-----BEGIN CERTIFICATE-----"
    }
    var certEnd: String {
        return "-----END CERTIFICATE-----"
    }
}
