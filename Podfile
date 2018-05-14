# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'VistusaPractice' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'CryptoSwift'
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'Alamofire', '~> 4.7'
  pod 'ObjectMapper', '~> 3.1'

  def testing_pods
    pod 'Mockingjay'
    pod 'Quick'
    pod 'Nimble'
    pod 'RxBlocking'
  end
  

  # Pods for VistusaPractice

  target 'VistusaPracticeTests' do
    inherit! :search_paths
    # Pods for testing
    testing_pods
  end

end
