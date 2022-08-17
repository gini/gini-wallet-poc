using_bundler = defined? Bundler
unless using_bundler
  puts "\nPlease re-run using:".red
  puts "  bundle exec pod install\n\n"
  exit(1)
end

platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

pod 'SwiftGen'
pod 'SwiftLint'

target 'skeleton' do
  # Use this for client-demo presentation
  # It shows touch feedback while presenting
  # pod 'ShowTime', :configurations => ['Debug']

  # Network debugger
  pod 'Wormholy', :configurations => ['Debug', 'Internal']
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      # Removes the default deployment target for some of frameworks
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
