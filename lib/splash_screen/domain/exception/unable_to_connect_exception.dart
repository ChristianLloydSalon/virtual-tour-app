class UnableToConnectException implements Exception {
  final String _message = 'Please check your internet connection';

  @override
  String toString() => _message;
}
