#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint amap_flutter_navi.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'amap_flutter_navi'
  s.version          = '0.0.1'
  s.summary          = 'Flutter高德地图导航'
  s.description      = <<-DESC
Flutter高德地图导航
                       DESC
  s.homepage         = 'https://github.com/dmlzj'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'dmlzj' => '3503859961@qq.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AMapNavi'
  s.static_framework = true
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
