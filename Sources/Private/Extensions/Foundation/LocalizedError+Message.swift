import Foundation

extension LocalizedError {
    func localizedMessage(key: String, args: [CVarArg] = []) -> String {
        let mainBundleLocalizedKey = NSLocalizedString(key, bundle: .main, comment: .empty)
        let resourceBundleLocalizedKey = NSLocalizedString(key, bundle: .resourcesBundle, comment: .empty)

        if mainBundleLocalizedKey != key {
            return String(format: mainBundleLocalizedKey, arguments: args)
        } else {
            return String(format: resourceBundleLocalizedKey, arguments: args)
        }
    }
}
