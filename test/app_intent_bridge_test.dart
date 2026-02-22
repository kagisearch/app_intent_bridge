import 'package:app_intent_bridge/app_intent_bridge.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppIntentBridge', () {
    test('emits AppIntent when onAppIntent is called', () async {
      final bridge = AppIntentBridge.instance;

      final future = bridge.intentStream.first;

      // Simulate a native call
      const channel = MethodChannel('com.kagi.app_intent_bridge/intent');
      await _simulateMethodCall(channel, 'onAppIntent', {
        'message': 'chat',
        'parameters': <String, dynamic>{'query': 'hello'},
      });

      final intent = await future;
      expect(intent.action, 'chat');
      expect(intent.parameters, {'query': 'hello'});
    });

    test('ignores unknown method calls', () async {
      const channel = MethodChannel('com.kagi.app_intent_bridge/intent');

      // Should not throw
      await _simulateMethodCall(channel, 'unknownMethod', {});
    });
  });

  group('AppIntent', () {
    test('toString returns readable format', () {
      const intent = AppIntent(action: 'chat', parameters: {'key': 'value'});
      expect(intent.toString(), 'AppIntent{action: chat, parameters: {key: value}}');
    });

    test('defaults parameters to empty map', () {
      const intent = AppIntent(action: 'test');
      expect(intent.parameters, isEmpty);
    });
  });
}

Future<void> _simulateMethodCall(
  MethodChannel channel,
  String method,
  dynamic arguments,
) async {
  final data = const StandardMethodCodec().encodeMethodCall(
    MethodCall(method, arguments),
  );
  await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.handlePlatformMessage(
    channel.name,
    data,
    (ByteData? reply) {},
  );
}
