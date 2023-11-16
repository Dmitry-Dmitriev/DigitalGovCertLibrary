import Foundation

extension URL {
    var fileName: String {
        return lastPathComponent
    }

    var filePath: String {
        return deletingLastPathComponent().absoluteString
    }
}
