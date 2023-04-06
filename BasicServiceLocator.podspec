Pod::Spec.new do |s|
  s.name             = 'BasicServiceLocator'
  s.version          = '0.0.1'
  s.summary          = 'Very Basic Service Locator'
  s.homepage         = 'https://github.com/iballan/BasicServiceLocator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Quick Bird' => 'mascot@quickbirdstudios.com' }
  s.source           = { :git => 'https://github.com/iballan/BasicServiceLocator.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/BasicServiceLocator/**/*'
end