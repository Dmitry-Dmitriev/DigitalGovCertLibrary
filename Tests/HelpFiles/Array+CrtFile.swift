import Foundation

extension Array where Element == CrtFile {
    static var cerList: [CrtFile] {
        return [.cerRoot, .cerSub]
    }
    static var crtList: [CrtFile] {
        return [.crt]
    }
    static var derList: [CrtFile] {
        return [.der]
    }
    static var pemList: [CrtFile] {
        return [.pem]
    }
    static var invalidCrtList: [CrtFile] {
        return [.invalid]
    }
}
