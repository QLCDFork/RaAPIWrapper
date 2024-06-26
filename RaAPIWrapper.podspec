# pod lib lint --verbose --allow-warnings RaAPIWrapper.podspec
# pod trunk push --verbose --allow-warnings RaAPIWrapper.podspec

Pod::Spec.new do |s|
  
  s.name = 'RaAPIWrapper'
  
  s.version = '1.2.4'

  s.summary = 'Makes it easier to define a network request.'
  
  s.description = 'Use `@propertyWrapper to provide the necessary data for network requests in a more aggregated form.'
  
  s.homepage = 'https://github.com/RakuyoKit/RaAPIWrapper'
  
  s.license = 'MIT'
  
  s.author = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source = { :git => 'https://github.com/RakuyoKit/RaAPIWrapper.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.14'
  s.tvos.deployment_target = '12.0'
  s.watchos.deployment_target = '5.0'
  
  s.swift_versions = ['5']
  
  s.module_name = 'APIWrapper'
  
  s.default_subspec = "Core"
  
  s.subspec "Core" do |cs|
    cs.source_files = 'Sources/Core/**/*'
    
    cs.resource_bundles = { 'RaAPIWrapper' => ['Sources/Core/PrivacyInfo.xcprivacy'] }
  end
  
  s.subspec "AF" do |cs|
    cs.source_files = 'Sources/Alamofire/*'
    
    cs.dependency "RaAPIWrapper/Core"
    cs.dependency "Alamofire", '>= 5.8.0', '< 6.0.0'
  end
  
end
