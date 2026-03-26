import AppIntents
import app_intent_bridge_proxy

@available(iOS, introduced: 16.0)
struct VoiceIntent: AppIntent {
    static var title: LocalizedStringResource = "Voice"
    static var openAppWhenRun: Bool = true

    @Dependency
    private var appIntentProxy: AppIntentProxy

    func perform() async throws -> some IntentResult {
        await appIntentProxy.action("voice", [:])
        return .result()
    }
}
