abstract class AppError {
  final int code;
  final String message;

  AppError(this.code, this.message);
}

class AppDataSourceError implements AppError {
  @override
  final int code;
  @override
  final String message;

  AppDataSourceError([this.code = 500, this.message = '']);
}
