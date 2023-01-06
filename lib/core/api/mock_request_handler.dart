import 'dart:convert';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import '../config/config.dart';
import 'client.dart';

class AppApiMockRequestHandler {
  static const secret = 'my-secret';

  final RequestOptions options;
  final RequestInterceptorHandler handler;
  late final Database _database;
  final Function(String) _reset;
  late final String endpoint;

  AppApiMockRequestHandler(this.options, this.handler, this._database, this._reset);

  Future<void> handleRequest() async {
    final matches = RegExp(r'^/(\w+)(?:/(?:(\d+)|(reset)))?$').firstMatch(options.path);

    try {
      if (matches == null) {
        throw 404;
      }

      endpoint = matches[1]!;
      final id = matches[2] == null ? null : int.parse(matches[2]!);
      final reset = matches[3] != null;

      /// Ungültiger Anmeldeversuch -> 401
      if (endpoint == 'login') {
        return _resolve(200, {'token': _token});
      }

      /// Unbekannter Endpoint -> 404
      await _verifyEndpoint(endpoint);

      /// Ungültiges Token -> 401
      await _verifyToken();

      /// ab hier wird der eigentliche Request behandelt
      if (reset) {
        await _reset(endpoint);
        return await _resolveGetAll();
      }

      if (options.method == 'GET' && id == null) {
        return await _resolveGetAll();
      }

      if (options.method == 'GET' && id != null) {
        return await _resolveGetOne(id);
      }

      if (options.method == 'PUT' && id != null) {
        return await _resolvePut(id);
      }

      if (options.method == 'POST' && id == null) {
        return await _resolvePost();
      }

      if (options.method == 'DELETE' && id != null) {
        return await _resolveDelete(id);
      }

      throw 404;
    } catch (e) {
      _reject(e as int);
    }
  }

  Future<void> _resolveGetAll() async {
    final items = await _database.query(endpoint);
    _resolve(200, items);
  }

  Future<void> _resolveGetOne(int id) async {
    final items = await _database.query(endpoint, where: 'id = ? ', whereArgs: [id]);
    items.isEmpty ? throw 404 : _resolve(200, items[0]);
  }

  Future<void> _resolvePut(int id) async {
    final data = jsonDecode(options.data) as Json;
    if (data['value'] as int < 0) {
      throw 422;
    }
    await _database.update(endpoint, data, where: 'id = ? ', whereArgs: [id]);
    await _resolveGetOne(id);
  }

  Future<void> _resolvePost() async {
    final data = jsonDecode(options.data) as Json;
    data['id'] = null;
    final insertId = await _database.insert(endpoint, data);
    final items = await _database.query(endpoint, where: 'id = ? ', whereArgs: [insertId]);
    _resolve(201, items[0]);
  }

  Future<void> _resolveDelete(int id) async {
    await _database.delete(endpoint, where: 'id = ?', whereArgs: [id]);
    _resolve(200);
  }

  Future<void> _verifyEndpoint(String endpoint) async {
    try {
      Sqflite.firstIntValue(await _database.rawQuery('SELECT COUNT(*) FROM $endpoint'));
    } catch (_) {
      throw 404;
    }
  }

  Future<void> _verifyToken() async {
    try {
      final matches = RegExp(r'^Bearer\s+(.*)$').firstMatch(options.headers[HttpHeaders.authorizationHeader]);
      JWT.verify(matches![1]!, SecretKey(secret));
    } catch (_) {
      throw 401;
    }
  }

  String get _token {
    final credentials = jsonDecode(options.data) as Json;

    if (!(RegExp(r'^\d{6}$').hasMatch(credentials['pNumber']) && credentials['password'] == 'test123')) {
      throw 401;
    }

    /// Die Token-TTL ist in der pNumber "kodiert". Damit wird in den Tests ein frühzeitiges session expired simuliert.
    /// * 123456 => Token ist gültig bis 3:00 am nächsten Tag
    /// * jede andere Zahl => TTL in Sekunden ab jetzt
    final now = DateTime.now();
    final expires = credentials['pNumber'] == '123456' //
        ? DateTime(now.year, now.month, now.day, 27)
        : now.add(Duration(seconds: int.parse(credentials['pNumber'])));

    return JWT({
      'iss': AppConfig().apiBaseUrl,
      'exp': expires.millisecondsSinceEpoch ~/ 1000,
    }).sign(SecretKey(secret));
  }

  void _resolve(int statusCode, [dynamic data]) {
    handler.resolve(
      Response(
        data: data,
        statusCode: statusCode,
        requestOptions: options,
      ),
      true,
    );
  }

  void _reject(int statusCode) {
    handler.reject(
      DioError(
        requestOptions: options,
        response: Response(
          requestOptions: options,
          statusCode: statusCode,
        ),
      ),
      true,
    );
  }
}
