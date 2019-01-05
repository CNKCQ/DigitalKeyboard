#
# Be sure to run `pod lib lint DigitalKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    
    s.name         = "DigitalKeyboard"
    s.version      = "1.3.0"
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
    
    
    
    s.source_files = 'DigitalKeyboard/Classes/**/*'
    s.resources = 'DigitalKeyboard/Assets/**/*'
    
    s.framework  = "UIKit"

end
