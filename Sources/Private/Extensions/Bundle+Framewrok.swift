import Foundation

extension Bundle {

    private static let moduleName = "DigitalGovCertLibrary"
    private static let resourcePath = "DGCLResources"
    // See: DigitalGovCertLibrary.podspec, s.resource_bundles
    private static let resourceExt = "bundle"

    static var resourcesBundle: Bundle {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        let frameworkBundle = Bundle(identifier: moduleName) ?? customFileFrameworkBundle

        guard let resourceBundleURL = frameworkBundle.url(forResource: resourcePath,
                                                          withExtension: resourceExt),
              let resourceBundle = Bundle(url: resourceBundleURL) else {
            return frameworkBundle
        }
        return resourceBundle
#endif
    }

    private static var customFileFrameworkBundle: Bundle {
        return Bundle(for: Certificate.self)
    }
}
