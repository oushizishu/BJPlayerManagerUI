#
# Be sure to run `pod lib lint BJPlayerManagerUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BJPlayerManagerUI'
  s.version          = '0.1.7.2'
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
  s.source           = { :git => 'https://github.com/baijia/BJPlayerManagerUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'BJPlayerManagerUI/Classes/**/*'
  
  s.resource_bundles = {
     'BJPlayerManagerUI' => ['BJPlayerManagerUI/Assets/*.png']
  }
  
    s.subspec 'BJPlayerManagerCore' do |ss|
        ss.xcconfig = { "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) PODSPEC_NAME=#{s.name} PODSPEC_VERSION=#{s.version}" }
        ss.vendored_frameworks = "frameworks/BJPlayerManagerCore.framework"
        ss.frameworks = ['CoreGraphics', 'Foundation', 'UIKit', 'MediaPlayer', 'CoreTelephony']
		
	    ss.dependency "AFNetworking" 
	    ss.dependency "YYModel"
	    ss.dependency "LogStat"
	    ss.dependency 'BJVideoPlayer'
	    ss.dependency 'ASIHTTPRequest'
	    ss.dependency 'SDWebImage/GIF'
	    ss.dependency 'BJLiveBase/Base', '~>1.0.0-alpha'
	    ss.dependency 'BJLiveBase/Networking', '~>1.0.0-alpha'
    end

  s.dependency 'MBProgressHUD'
  s.dependency 'Masonry'
#  s.dependency 'BJPlayerManagerCore'

  s.prefix_header_contents =
    '#import <Masonry/Masonry.h>',
    '#import <MBProgressHUD/MBProgressHUD.h>',
    '#import <Masonry/Masonry.h>',
    '#import <BJPlayerManagerCore/BJPlayerManagerCore.h>'


end
