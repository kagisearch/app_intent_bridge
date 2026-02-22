import Flutter
import AppIntents

public class AppIntentBridgePlugin: NSObject, FlutterPlugin {
    public static let shared = AppIntentBridgePlugin()

    private var channel: FlutterMethodChannel?
    private var pendingIntents: [[String: Any]] = []
    
    private var appIntentProxy = AppIntentProxy()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "com.kagi.app_intent_bridge/intent",
            binaryMessenger: registrar.messenger()
        )
        shared.channel = channel
        registrar.addMethodCallDelegate(shared, channel: channel)

        // Flush any intents that arrived before the channel was ready
        for intent in shared.pendingIntents {
            channel.invokeMethod("onAppIntent", arguments: intent)
        }
        shared.pendingIntents.removeAll()
    }
    
    override init() {
        if #available(iOS 16.0, *) {
            AppDependencyManager.shared.add(dependency: self.appIntentProxy)
            appIntentProxy.callback = { target, parameters in
                AppIntentBridgePlugin.shared.handleIntent(message: target, parameters: parameters)
            }
        }
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(FlutterMethodNotImplemented)
    }

    /// Called from native code (e.g. AppDelegate) to forward an intent to Flutter.
    public func handleIntent(message: String, parameters: Any) {
        let arguments: [String: Any] = ["message": message, "parameters": parameters]
        if let channel = channel {
            channel.invokeMethod("onAppIntent", arguments: arguments)
        } else {
            pendingIntents.append(arguments)
        }
    }
}
