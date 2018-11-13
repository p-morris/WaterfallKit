Pod::Spec.new do |spec|
  spec.name = "WaterfallKit"
  spec.version = "1.0.0"
  spec.summary = "A simple library for loading prioritising video adverts from multiple ad networks, ensuring maximum fill rate."
  spec.homepage = "https://github.com/p-morris/WaterfallKit"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Pete Morris" => 'pete@iosfaststart.com' }
  spec.social_media_url = "https://stackoverflow.com/users/10246061/pete-morris"
  spec.swift_version = '4.2'
  spec.platform = :ios, "12"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/p-morris/WaterfallKit.git", tag: "v#{spec.version}", submodules: true }

  spec.subspec 'Core' do |core|
    core.source_files = "WaterfallKit/Core/*"
  end

  spec.subspec 'AdColony' do |adcolony|
    adcolony.source_files = 'WaterfallKit/AdColony/*.swift', 'WaterfallKit/AdColony/*.h'
    adcolony.vendored_frameworks = 'WaterfallKit/AdColony/AdColony.framework'
    adcolony.public_header_files = 'WaterfallKit/AdColony/Headers.h'
    adcolony.preserve_paths = 'WaterfallKit/AdColony/AdColony.framework'
    adcolony.libraries = 'z.1.2.5',
    adcolony.frameworks = 'AdColony', 'AdSupport', 'AudioToolbox', 'AVFoundation', 'CoreMedia', 'CoreTelephony', 'JavaScriptCore', 'MessageUI', 'MobileCoreServices', 'SystemConfiguration'
    adcolony.weak_frameworks = 'Social', 'StoreKit', 'WatchConnectivity', 'WebKit'
    adcolony.dependency 'WaterfallKit/Core'
  end

end