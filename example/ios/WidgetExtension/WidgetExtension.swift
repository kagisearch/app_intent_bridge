import WidgetKit
import SwiftUI
import AppIntents

// MARK: - Placeholder timeline provider

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DummyEntry {
        DummyEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (DummyEntry) -> ()) {
        let entry = DummyEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [DummyEntry(date:Date())], policy: .never)
        completion(timeline)
    }
}

struct DummyEntry: TimelineEntry {
    let date: Date
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            
        }
    }
}

//

struct IntentButtonWidget: View {
    @Environment(\.widgetFamily) var family
    
    let image: String
    let intent: any AppIntent
    
    var body: some View {
        Group {
            if #available(iOS 17.0, *) {
                Button(intent: intent) {
                    Image(systemName: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(iconPadding)
                        .clipShape(RoundedRectangle(cornerRadius: iconCornerRadius))
                }
                .buttonStyle(.plain)
            } else {
                Button {
                    Task {
                        try? await intent.perform()
                    }
                } label: {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(iconPadding)
                        .clipShape(RoundedRectangle(cornerRadius: iconCornerRadius))
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private var iconPadding: CGFloat {
        switch family {
        case .accessoryCircular:
            return 0
        default:
            return 16
        }
    }

    private var iconCornerRadius: CGFloat {
        switch family {
        case .accessoryCircular:
            return 0
        default:
            return 16
        }
    }
}

// MARK: - Widget


/// Chat widget with a single button that can be added to the lock screen.
struct ChatWidget: Widget {
    let kind = "ChatWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { _ in
            IntentButtonWidget(image: "message", intent: ChatIntent())
                //.containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("Chat")
        .description("Let's you quickly start a new chat.")
        .supportedFamilies([.accessoryCircular])
    }
}

/// Voice widget with a single button that can be added to the lock screen.
struct VoiceWidget: Widget {
    let kind = "VoiceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { _ in
            IntentButtonWidget(image: "waveform", intent: VoiceIntent())
                //.containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("Voice")
        .description("Let's you quickly start a new voice conversation.")
        .supportedFamilies([.accessoryCircular])
    }
}

/// Control widget for chat that can be added to the Control center and the lock screen actions, or assigned to the action button.
@available(iOS 18.0, *)
struct ChatControlWidget: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: "ChatControlWidget") {
            ControlWidgetButton(action: ChatIntent()) {
                Label("Chat", image: "message")
            }
        }
        .displayName("Chat")
        .description("Let's you quickly start a new chat.")
    }
}

/// Control widget for voice that can be added to the Control center and the lock screen actions, or assigned to the action button.
@available(iOS 18.0, *)
struct VoiceControlWidget: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(kind: "VoiceControlWidget") {
            ControlWidgetButton(action: VoiceIntent()) {
                Label("Voice", image: "waveform")
            }
        }
        .displayName("Voice")
        .description("Let's you quickly start a new voice conversation.")
    }
}


// MARK: - Preview

//#Preview(as: .systemSmall) {
//    WidgetExtension()
//} timeline: {
//    DummyEntry(date: .now)
//}
