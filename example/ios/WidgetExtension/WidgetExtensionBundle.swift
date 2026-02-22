//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by rumori on 2026. 02. 22..
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        ChatWidget()
        VoiceWidget()
        if #available(iOS 18.0, *) {
            VoiceControlWidget()
            ChatControlWidget()
        }
    }
}
