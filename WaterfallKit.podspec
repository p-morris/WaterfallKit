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
  spec.source_files = "WaterfallKit/Core/*"

  subspec 'AdColony' do |sp|
    sp.source_files = 'WaterfallKit/AdColony/*'
    sp.dependency 'AdColony', '3.3.6'
  end

end