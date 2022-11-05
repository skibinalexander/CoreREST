Pod::Spec.new do |s|
  s.name             = 'CoreREST'
  s.version          = '0.0.2'
  s.summary          = 'Network adapter for Alamofire library implementation with SwiftyJSON parser'
  s.description      = 'Usefull network adapter Alamofire library implementation with SwiftyJSON parser'

  s.homepage         = 'https://github.com/skibinalexander/CoreREST.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Skibin Alexander' => 'skibinalexander@gmail.com' }
  s.source           = { :git => 'https://github.com/skibinalexander/CoreREST.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_version = "5.5"
  s.source_files = 'Sources/CoreREST/**/*'
  s.dependency 'Alamofire', '~> 5.0'
  s.dependency 'SwiftyJSON', '~> 4.0'
end
