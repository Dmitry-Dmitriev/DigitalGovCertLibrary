
import Foundation

protocol ManagableLoader: AnyObject {
    associatedtype Output: LoadingItem
    func load(completion: @escaping (Output) -> Void)
}
