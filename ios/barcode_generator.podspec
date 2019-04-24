#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'barcode_generator'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.ios.deployment_target = '8.0'
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  # s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.{h,m}'
  s.swift_version = '4.0'
  s.dependency 'Flutter'
  s.dependency 'ZXingObjC'
  s.static_framework = true
  
end

