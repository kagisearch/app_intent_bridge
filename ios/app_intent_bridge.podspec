Pod::Spec.new do |s|
  s.name             = 'app_intent_bridge'
  s.version          = '0.1.0'
  s.summary          = 'Flutter plugin bridging iOS App Intents to Dart.'
  s.description      = 'Provides a MethodChannel-based bridge so iOS App Intents can send actions to Flutter.'
  s.homepage         = 'https://github.com/kagisearch/app_intent_bridge'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Kagi' => 'support@kagi.com' }
  s.source           = { :path => '.' }
  s.platform         = :ios, '13.0'
  s.swift_version    = '5.0'
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'app_intent_bridge_proxy'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
