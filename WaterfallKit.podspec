Pod::Spec.new do |spec|
  spec.name = "WaterfallKit"
  spec.version = "1.0.2"
  spec.summary = "Prioritize and waterfall requests for interstitial video ads from AdColony, AppLovin, and Admob. Achieve 100% fill rate."
  spec.homepage = "https://github.com/p-morris/WaterfallKit"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Pete Morris" => 'pete@iosfaststart.com' }
  spec.social_media_url = "https://stackoverflow.com/users/10246061/pete-morris"
  spec.swift_version = '4.2'
  spec.platform = :ios, "12"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/p-morris/WaterfallKit.git", tag: "#{spec.version}", submodules: true }
  spec.static_framework = true
  spec.subspec 'Core' do |core|
    core.source_files = 'WaterfallKit/Core/*'
  end

  spec.subspec 'AdColony' do |adcolony|
    adcolony.source_files = 'WaterfallKit/AdColony/*.swift'
    adcolony.dependency 'AdColony', '3.3.6'
    adcolony.dependency 'WaterfallKit/Core'
  end

  spec.subspec 'AdMob' do |admob|
    admob.source_files = 'WaterfallKit/AdMob/*.swift'
    admob.dependency 'Google-Mobile-Ads-SDK', '7.35.2'
    admob.dependency 'WaterfallKit/Core'
  end

  spec.subspec 'AppLovin' do |applovin|
    applovin.source_files = 'WaterfallKit/AppLovin/*.swift'
    applovin.dependency 'AppLovinSDK', '5.1.2'
    applovin.dependency 'WaterfallKit/Core'
  end

  spec.test_spec do |test_spec|
    test_spec.requires_app_host = true
    test_spec.source_files = 'Tests/*', 'WaterfallKit/*'
    test_spec.pod_target_xcconfig = { 'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO' }
  end

end