import '../../../../../core/errors/exceptions.dart';

mixin AppRemoteDataSourceMixin {
  Future<T> request<T>(Future<dynamic> Function() request) async {
    try {
      final response = await request();
      return response as T;
    } on AppApiException catch (e) {
      throw AppDataSourceException(e.code, e.message);
    }
  }
}
