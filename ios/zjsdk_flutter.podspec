#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint zjsdk_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'zjsdk_flutter'
  s.version          = '0.1.2'
  s.summary          = 'zjsdk ads flutter plusin package.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/liqiqing/ZJSDK.git'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'kkmm' => 'cocos_kkmm@163.com' }
  s.source           = { :git => 'https://github.com/HalfOfSunshine/ZjsdkFlutterPlugin.git', :tag => s.version.to_s }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'ZJSDK'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
