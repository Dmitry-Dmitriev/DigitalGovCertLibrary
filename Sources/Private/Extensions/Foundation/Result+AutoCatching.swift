import Foundation

extension Result where Failure == Error {
    init(autoCatching: @autoclosure () throws -> Success) {
        self.init(catching: autoCatching)
    }
}
