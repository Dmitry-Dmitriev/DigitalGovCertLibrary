
import Foundation

enum LoadingStatus<T> {
    case idle
    case loading
    case finished(result: T)
}
