# Uncomment the next line to define a global platform for your project
# platform :ios, '13.5'

install! 'cocoapods',
            :warn_for_unused_master_specs_repo => false

target 'Skateboarding' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Skateboarding
  pod 'Firebase','6.27.0'
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'FirebaseUI/Storage'
  pod 'SVProgressHUD','2.2.5'
  pod 'CLImageEditor/AllTools','0.2.4'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'Eureka'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end
end
