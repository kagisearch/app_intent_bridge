import 'package:app_intent_bridge/app_intent_bridge.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _log = '';

  @override
  void initState() {
    super.initState();
    AppIntentBridge.instance.intentStream.listen((intent) {
      setState(() {
        _log += 'Received intent: ${intent.action} with parameters: ${intent.parameters}\n';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('App Intent Bridge Example')),
        body: SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Text(_log.isEmpty ? 'Waiting for intents...' : _log)),
      ),
    );
  }
}
