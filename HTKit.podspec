Pod::Spec.new do |s|
  s.name         = "HTKit"
  s.version      = "1.0.0"
  s.platform     = :ios
  s.summary      = "A collection of tools "
  s.homepage     = "https://github.com/hoteltonight/HTKit"
  s.license      = 'MIT'
  s.author       = { "Jacob Jennings" => "jacob.r.jennings@gmail.com" }
  s.source       = { :git => "https://github.com/hoteltonight/HTKit.git", :tag => '1.0.0' }
  s.ios.deployment_target = '5.0'
  s.source_files = 'Classes', '*.{h,m}'
  s.requires_arc = true
  s.dependency 'JJCachedAsyncViewDrawing', '~> 1.0.1'
  s.dependency 'HTRasterView', '~> 1.2.9'
  s.dependency 'HTAutocompleteTextField', '~> 1.1.2'
  s.dependency 'HTGradientEasing', '~> 0.0.4'
  s.dependency 'HTDelegateProxy', '~> 1.0.1'
  s.dependency 'HTCoreImage', '~> 1.0.0'
  s.dependency 'SFObservers', '~> 1.0'
  s.dependency 'UIViewPlusPosition', '~> 0.0.1'
end
