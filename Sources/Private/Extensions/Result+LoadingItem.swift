import Foundation

extension Result: LoadingItem {
    var isFailed: Bool {
        switch self {
        case .success: return false
        case .failure: return true
        }
    }
}
