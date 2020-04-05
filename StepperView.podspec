#
# Be sure to run `pod lib lint StepperView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StepperView'
  s.version          = '0.1.1'
  s.swift_version  = '5.0'
  s.summary          = 'SwiftUI component for StepperView'
  s.description      = 'Stepper View componet for SwiftUI'
  s.homepage         = 'https://github.com/badrinathvm/StepperView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'badrinathvm' => 'badrinathvm@gmail.com' }
  s.source           = { :git => 'https://github.com/badrinathvm/StepperView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/badrivm'
  s.ios.deployment_target = '11.0'
  s.source_files = 'StepperView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'StepperView' => ['StepperView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
