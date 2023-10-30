
import Foundation

extension Result {
    var void: Result<Void, Error> {
        switch self {
        case .success: return .success(Void())
        case let .failure(error): return .failure(error)
        }
    }
}
