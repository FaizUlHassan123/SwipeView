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

end
post_install do |installer|
    `find Pods -regex 'Pods/pop.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)pop\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
end
