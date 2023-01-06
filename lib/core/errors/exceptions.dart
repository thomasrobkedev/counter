class AppDataSourceException implements Exception {
  final int code;
  final String message;

  AppDataSourceException([this.code = 0, this.message = '']);
}

class AppApiException implements Exception {
  final int code;
  final String message;

  AppApiException(int? code, String? message)
      : code = code ?? 400,
        message = message ?? '';
}
