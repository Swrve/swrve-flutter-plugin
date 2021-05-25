#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint swrve_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'swrve_plugin'
  s.version          = '0.2'
  s.summary          = 'Flutter plugin for Swrve native SDKs'
  s.description      = <<-DESC
  Flutter plugin for Swrve native SDKs
                       DESC
  s.homepage         = 'https://swrve.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Swrve' => 'support@swrve.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'SwrveSDK', '~> 6.8'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
