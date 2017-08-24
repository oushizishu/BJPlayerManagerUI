#
# Be sure to run `pod lib lint BJPlayerManagerUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BJPlayerManagerUI'
  s.version          = '0.1.5-dylib'
  s.summary          = 'BJPlayerManagerUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/baijia/BJPlayerManagerUI.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '辛亚鹏' => 'xinyapeng@baijiahulian.com' }
  
  # git
  s.source           = { :git => 'https://github.com/baijia/BJPlayerManagerUI.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  
  # # framework
  s.ios.preserve_paths       = 'BJPlayerManagerUI/BJPlayerManagerUI.framework'
  s.ios.public_header_files  = 'BJPlayerManagerUI/BJPlayerManagerUI.framework/Versions/A/Headers/**/*.h'
  s.ios.source_files         = 'BJPlayerManagerUI/BJPlayerManagerUI.framework/Versions/A/Headers/**/*.h'
  s.ios.resource             = 'BJPlayerManagerUI/BJPlayerManagerUI.framework/Versions/A/Resources/**/*'
  s.ios.vendored_frameworks  = 'BJPlayerManagerUI/BJPlayerManagerUI.framework'

  s.frameworks = ['CoreGraphics', 'Foundation', 'MobileCoreServices', 'Photos', 'UIKit']
   s.xcconfig = {"ENABLE_BITCODE" => "NO", "CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES" => "YES"}

  # # library
  # s.source_files = 'BJPlayerManagerUI/Classes/**/*'
  # s.resource_bundles = {
  #  'BJPlayerManagerUI' => ['BJPlayerManagerUI/Assets/*.png']
  # }
  
  s.dependency 'MBProgressHUD'
  s.dependency 'Masonry'
  s.dependency 'BJPlayerManagerCore' , '~> 0.3.0'

  s.prefix_header_contents =
    '#import <Masonry/Masonry.h>',
    '#import <MBProgressHUD/MBProgressHUD.h>',
    '#import <Masonry/Masonry.h>',
    '#import <BJPlayerManagerCore/BJPlayerManagerCore.h>'

end
