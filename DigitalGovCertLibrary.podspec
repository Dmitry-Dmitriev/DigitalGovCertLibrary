Pod::Spec.new do |s|
  s.name                = 'DigitalGovCertLibrary'
  s.version             = '1.0.0'
  s.summary             = 'iOS SDK of myTarget Advertising Network'
  s.description         = 'The myTarget Advertising Network allows developers to monetize their websites and mobile apps using myTarget ads'
  s.homepage            = 'https://target.my.com'
  s.readme              = 'https://raw.githubusercontent.com/myTargetSDK/mytarget-ios/master/README.md'
  s.changelog           = 'https://raw.githubusercontent.com/myTargetSDK/mytarget-ios/master/CHANGELOG.md'
  s.documentation_url   = 'https://target.my.com/partners/help/sdk'
  s.license             = { :type => 'LGPL-3.0'}
  s.authors             = { 'My.com' => 'sdk_mytarget@corp.my.com' }
  s.platform            = :ios, '12.4'
  s.cocoapods_version   = '>= 1.10.0'
  s.source              = { :git => 'git@github.com:Dmitry-Dmitriev/DigitalGovCertLibrary.git', :tag => "1.0.0" }
#  s.source_files        = 'Sources/**/*.{h,m,swift}'
  s.resource_bundles = {
   "DGCLResources" => ["Sources/Certs/*"]
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
#  s.vendored_frameworks = 'digital.gov.rus.cert.support.xcframework'
  s.requires_arc        = true
  s.swift_version = '5.0'
end
