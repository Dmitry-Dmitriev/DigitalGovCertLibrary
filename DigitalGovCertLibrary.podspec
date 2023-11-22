Pod::Spec.new do |s|
  s.name                = 'DigitalGovCertLibrary'
  s.version             = '1.0.0'
  s.summary             = 'DigitalGovCertLibrary for iOS'
  s.homepage            = 'https://github.com/myTargetSDK/DigitalGovCertLibrary-iOS'
  s.readme              = 'https://github.com/myTargetSDK/DigitalGovCertLibrary-iOS/tree/main/README.md'
  s.documentation_url   = 'https://github.com/myTargetSDK/DigitalGovCertLibrary-iOS'
  s.license             = { :type => 'MIT'}
  s.authors             = { 'vk.team' => 'digital-gov-cert-library-ios@vk.team' }
  s.platform            = :ios, '12.4'
  s.cocoapods_version   = '>= 1.10.0'
  s.source              = { :git => 'git@github.com:Dmitry-Dmitriev/DigitalGovCertLibrary.git', :tag => s.version }
#  s.source_files        = 'Sources/**/*.{h,m,swift}'
  s.resource_bundles = {
   "DGCLResources" => [
			"Sources/Resources/Certs/*",
			"Sources/Resources/Localization/*",
		]
}
  s.subspec 'Private' do |ss|
    ss.source_files = 'Sources/Private/**/*.{h,m,swift}'
  end
  s.subspec 'Public' do |ss|
    ss.source_files = 'Sources/Public/**/*.{h,m,swift}'
  end
  s.test_spec 'DGCLTests' do |test_spec|
    test_spec.source_files = 'Tests/**/*.{h,m,swift}'
  end
  s.requires_arc        = true
  s.swift_version = '5.0'
end