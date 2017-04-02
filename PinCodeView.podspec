#
#  Be sure to run `pod spec lint PinCodeView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "PinCodeView"
  s.version      = "0.0.1"
  s.summary 	 = "A drop in view for pin code input"
  s.description  = <<-DESC
	A drop in view for getting pin code from the user.
	Main use case is input for codes received in SMS/email etc.
                   DESC
  s.homepage     = "http://www.github.com/arielpollack/PinCodeView"
  s.license      = "MIT"
  s.author             = { "Ariel Pollack" => "pollack.ariel@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/arielpollack/PinCodeView.git", :tag => "#{s.version}" }
  s.source_files  = "Source/", "Source/*.swift"

end
