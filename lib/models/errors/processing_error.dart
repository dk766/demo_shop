class ProcessingError implements Exception {
  final String message;

  ProcessingError(this.message);

  String toString() {
    return 'ProcessingError message=$message';
  }
}
