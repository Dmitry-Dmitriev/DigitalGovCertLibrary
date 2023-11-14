import Foundation

extension Result {
    var void: Result<Void, Failure> {
        return flatMap { _ in
            return .success(Void())
        }
    }
}
