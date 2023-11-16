import Foundation

extension Bundle {
    private static let moduleName = "DigitalGovCertLibrary"
    private static let resource = "DGCLResources"
    // See: DigitalGovCertLibrary.podspec, s.resource_bundles
    private static let resourceExt = "bundle"

    static var resourcesBundle: Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        let bundle = Bundle(identifier: moduleName) ?? customFileBundle
        let resourceBundleURL = bundle.url(forResource: resource,
                                           withExtension: resourceExt)
        guard let resourceBundleURL,
              let resourceBundle = Bundle(url: resourceBundleURL) else {
            return bundle
        }
        return resourceBundle
#endif
    }

    private static var customFileBundle: Bundle {
        return Bundle(for: Certificate.self)
    }
}
