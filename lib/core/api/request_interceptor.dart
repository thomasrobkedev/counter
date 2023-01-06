import 'dart:io';

import 'package:dio/dio.dart';

import 'token.dart';

class AppApiRequestInterceptor extends Interceptor {
  final AppApiToken _token;
  AppApiRequestInterceptor(this._token);

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${_token.get()}',
      'X-${HttpHeaders.authorizationHeader}': 'Bearer ${_token.get()}',
    };

    /// Hier können requests vor dem Abschicken noch manipuliert werden.
    /// z.B. um REST-konforme requests von der App in das Format zu transformieren, dass die Api tatsächlich benötigt

    super.onRequest(options, handler);
  }
}
