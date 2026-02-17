#
# Be sure to run `pod lib lint StepperView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StepperView'
  s.version          = '2.0'
  s.swift_version    = '5.9'
  s.summary          = 'SwiftUI iOS component for Step Indications.'
  s.description      = 'Stepper View Indication componet for SwiftUI'
  s.homepage         = 'https://github.com/badrinathvm/StepperView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => 'https://github.com/badrinathvm/StepperView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/badrivm'
  s.ios.deployment_target = '13.0'
  s.watchos.deployment_target = '7.0'
  s.macos.deployment_target = '10.15'
  s.source_files     = 'Sources/**/*.swift'

  # Yams + YAML resources only on iOS and macOS (not supported on watchOS)
  s.ios.dependency 'Yams', '~> 5.0'
  s.macos.dependency 'Yams', '~> 5.0'
  s.ios.resource_bundles = {
    'StepperView' => ['Sources/StepperView/Resources/**/*.yaml']
  }
  s.macos.resource_bundles = {
    'StepperView' => ['Sources/StepperView/Resources/**/*.yaml']
  }
end
