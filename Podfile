# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SwipeView' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwipeView
  pod "Koloda"
  pod 'AlamofireImage'


  target 'SwipeViewTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SwipeViewUITests' do
    # Pods for testing
  end

#end
#post_install do |installer|
#    `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
#end
#  For MAcbook pro with m1 chip and xcode 14 issue
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'


    end
  end
end

end
