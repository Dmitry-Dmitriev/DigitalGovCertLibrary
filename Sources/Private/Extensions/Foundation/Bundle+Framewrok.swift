//  DigitalGovCertLibrary

//  Copyright (c) 2023-Present DigitalGovCertLibrary Team - https://github.com/myTargetSDK/DigitalGovCertLibrary-iOS
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

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
