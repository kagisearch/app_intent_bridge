/// A generic app intent received from the native platform.
class AppIntent {
  /// The action identifier (e.g. 'chat', 'voice_mode').
  final String action;

  /// Optional parameters passed with the intent.
  final Map<String, dynamic> parameters;

  const AppIntent({required this.action, this.parameters = const {}});

  @override
  String toString() => 'AppIntent{action: $action, parameters: $parameters}';
}
