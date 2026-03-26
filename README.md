# app_intent_bridge

A Flutter package to receive iOS App Intents.

# Getting started

Add `app_intent_bridge` to your Flutter project:
``` bash
flutter pub add app_intent_bridge
```

In your iOS project `Podfile` add the following for each Widget Extension you want to use intents in:
``` ruby
target 'WidgetExtension' do
  use_frameworks!

  pod 'app_intent_bridge_proxy', :path => '.symlinks/plugins/app_intent_bridge/ios'
end
```

In you App Intent use the following to send messages to your Flutter app:
``` swift
import AppIntents
import app_intent_bridge_proxy

@available(iOS, introduced: 16.0)
struct ChatIntent: AppIntent {
    static var title: LocalizedStringResource = "Chat"
    static var openAppWhenRun: Bool = true

    @Dependency
    private var appIntentProxy: AppIntentProxy

    func perform() async throws -> some IntentResult {
        appIntentProxy.action("chat", [:])
        return .result()
    }
}
```

In your Flutter app subscribe to the App Intent stream:
``` dart
AppIntentBridge.instance.intentStream.listen((intent) {
    debugPrint('App Intent action received ${intent.action} with parameters: ${intent.parameters}';
});
```

See the [Example](example) project for more details.
