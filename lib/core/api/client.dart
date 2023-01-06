import 'dart:convert';

import 'package:dio/dio.dart';

import '../../features/settings/data/datasources/local/data_source.dart';
import '../config/config.dart';
import '../errors/exceptions.dart';
import 'mock.dart';
import 'request_interceptor.dart';
import 'response_interceptor.dart';

typedef Json = Map<String, dynamic>;

class AppApiClient {
  final Dio _dio;
  final AppApiMock _mock;
  final AppApiRequestInterceptor _requestInterceptor;
  final AppApiResponseInterceptor _responseInterceptor;
  final SettingsLocalDataSource _settingsLocalDataSource;

  AppApiClient(
    this._dio,
    this._mock,
    this._requestInterceptor,
    this._responseInterceptor,
    this._settingsLocalDataSource,
  ) {
    _dio.options.baseUrl = AppConfig().apiBaseUrl.replaceAll('[[HOUSE]]', _settingsLocalDataSource.getSettings().houseNumber);

    _dio.interceptors.add(_requestInterceptor);
    _dio.interceptors.add(_responseInterceptor);

    if (AppConfig().apiBaseUrl == AppConfig().apiMock) {
      _dio.interceptors.add(_mock);
    }
  }

  Future<dynamic> get(String path) async {
    return await _fetch(
      () => _dio.get(path),
    );
  }

  Future<dynamic> put(String path, Json data) async {
    return await _fetch(
      () => _dio.put(path, data: jsonEncode(data)),
    );
  }

  Future<dynamic> post(String path, Json data) async {
    return await _fetch(
      () => _dio.post(path, data: jsonEncode(data)),
    );
  }

  Future<dynamic> delete(String path) async {
    return await _fetch(
      () => _dio.delete(path),
    );
  }

  Future<dynamic> _fetch(Future<Response> Function() request) async {
    try {
      final response = await request();
      return response.data;
    } on DioError catch (e) {
      throw AppApiException(
        e.response?.statusCode,
        e.response?.statusMessage,
      );
    }
  }
}
