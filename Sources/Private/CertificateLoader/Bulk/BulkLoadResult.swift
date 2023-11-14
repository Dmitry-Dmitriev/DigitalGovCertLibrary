import Foundation

struct BulkLoadResult: LoadingItem {
    let certs: [Certificate]
    let failResources: [BulkErrorLoadItem]

    var isFailed: Bool {
        !failResources.isEmpty
    }
}
