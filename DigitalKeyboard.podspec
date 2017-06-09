#
#  Be sure to run `pod spec lint IDCardKeyboard.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DigitalKeyboard"
  s.version      = "1.2.7"
  s.summary      = "A custom keyboard of DigitalKeyboard."

  s.description  = <<-DESC
                    it's a custom keyboard, you can use it to instead the system keyboard
                   DESC

  s.homepage     = "https://github.com/CNKCQ/DigitalKeyboard.git"
  s.screenshots  = "http://7xslr9.com1.z0.glb.clouddn.com/IDCardKeyboard.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "KingCQ" => "wangchengqvan@gmail.com" }
  # Or just: s.author    = "KingCQ"
  # s.authors            = { "KingCQ" => "wangchengqvan@gmail.com" }
  # s.social_media_url   = "http://twitter.com/KingCQ"


  # s.platform     = :ios
  # s.platform     = :ios, "9.0"

  #  When using multiple platforms
  s.ios.deployment_target = '9.0'

  s.source       = { :git => "https://github.com/CNKCQ/DigitalKeyboard.git", :tag => "#{s.version}" }



  s.source_files  = "DigitalKeyboard", "DigitalKeyboard/**/*.{h,m,swift}"
  s.exclude_files = "DigitalKeyboard/Exclude"

  # s.public_header_files = "Classes/**/*.h"



  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  s.resource_bundles = {
  'DigitalKeyboard' => ['DigitalKeyboard/Resources/**/*.png']
}



  # ―
  s.framework  = "UIKit"


end
