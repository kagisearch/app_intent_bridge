import 'dart:async';

import 'package:flutter/services.dart';

import 'app_intent.dart';

/// Receives app intents from the native iOS plugin via a MethodChannel
/// and exposes them as a broadcast stream.
class AppIntentBridge {
  AppIntentBridge._() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  static final instance = AppIntentBridge._();

  static const _channel = MethodChannel('com.kagi.app_intent_bridge/intent');

  final _controller = StreamController<AppIntent>.broadcast();

  /// A broadcast stream of intents received from the native side.
  Stream<AppIntent> get intentStream => _controller.stream;

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == 'onAppIntent') {
      final args = Map<String, dynamic>.from(call.arguments as Map);
      final action = args['message'] as String;
      final parameters = Map<String, dynamic>.from(args['parameters'] as Map);
      _controller.add(AppIntent(action: action, parameters: parameters));
    }
  }
}
