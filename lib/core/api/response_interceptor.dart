import 'package:dio/dio.dart';

class AppApiResponseInterceptor extends Interceptor {
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    /// Hier kann die response vor der Weiterleitung an die App noch manipuliert werden;
    /// z.B. um eine nicht-REST-konforme response von der Api in eine REST-konforme für die App zu transformieren

    super.onResponse(response, handler);
  }
}
