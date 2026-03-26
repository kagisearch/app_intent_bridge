Pod::Spec.new do |s|
  s.name             = 'app_intent_bridge_proxy'
  s.version          = '0.1.0'
  s.summary          = 'Lightweight proxy for app_intent_bridge, usable from app extensions without Flutter.'
  s.description      = 'Contains AppIntentProxy which can be used by WidgetExtensions and other app extensions to forward App Intent actions to the main app.'
  s.homepage         = 'https://github.com/kagisearch/app_intent_bridge'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Kagi' => 'support@kagi.com' }
  s.source           = { :path => '.' }
  s.platform         = :ios, '13.0'
  s.swift_version    = '5.0'
  s.source_files     = 'AppIntentBridgeProxy/Sources/**/*'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end
