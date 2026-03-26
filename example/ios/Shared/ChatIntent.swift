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
