import Foundation

extension String {
    static let empty = ""
    static let linebreak = "\n"
    static let comma = ","
    static let dot = "."
    static let doubleQuote = "\""
    static let singleQuote = "'"
    static let space = " "
}

extension String {
    init(_ any: Any) {
        self.init(describing: any)
    }
}
