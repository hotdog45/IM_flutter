#将代码保存到flutter_app目录下命名为Flutter.podspec
#
# NOTE: This podspec is NOT to be published. It is only used as a local source!
#

Pod::Spec.new do |s|
  s.name             = 'Flutter'
  s.version          = '1.22.4'
  s.summary          = 'High-performance, high-fidelity mobile apps.'
  s.description      = <<-DESC
Flutter provides an easy and productive way to build and deploy high-performance mobile apps for Android and iOS.
                       DESC
  s.homepage         = 'https://flutter.io'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Flutter Dev Team' => 'meng1711@sina.com' }
  s.source           = { :git => 'https://github.com/flutter/engine', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.vendored_frameworks = 'Flutter.framework', 'App.framework'
  s.resources = 'flutter_assets'
  s.source_files = '*.{h,m}'
  s.public_header_files = '*.h'
end
