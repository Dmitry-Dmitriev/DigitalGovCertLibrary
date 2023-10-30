

//import Foundation
//
//extension CertificateFile {
//    func load() throws -> Data {
//        let url = try makeURL()
//        let data = try loadData(atUrl: url)
//        return data
//    }
//
//    func makeURL() throws -> URL {
//        guard let certUrl = certBundle.url(forResource: certName, withExtension: certExtension.string)
//        else { throw missingFileError }
//
//        return certUrl
//    }
//}
//
//private extension CertificateFile {
//    func loadData(atUrl url: URL) throws -> Data {
//        do {
//            return try Data(contentsOf: url)
//        } catch {
//            throw readingFileError(reason: error.localizedDescription)
//        }
//    }
//}
