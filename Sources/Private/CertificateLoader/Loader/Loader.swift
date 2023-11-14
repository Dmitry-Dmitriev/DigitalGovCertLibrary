import Foundation

protocol Loader: AnyObject {
    associatedtype Output: LoadingItem
    func load(completion: @escaping (Output) -> Void)
}
