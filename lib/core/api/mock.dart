import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../config/config.dart';
import 'mock_request_handler.dart';

class AppApiMock extends Interceptor {
  late Database _database;

  AppApiMock();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppApiMockRequestHandler(options, handler, _database, _reset).handleRequest();
  }

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final name = AppConfig().environment.name;
    final path = '$databasesPath/$name.db';

    _database = await openDatabase(
      path,
      version: 2,
      onUpgrade: (db, _, __) => _create(db),
    );
  }

  Future<void> _create(Database db) async {
    final assetManifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> json = jsonDecode(assetManifest);

    final endpoints = json //
        .keys
        .map((path) => path.replaceFirstMapped(RegExp(r'^.*\/database\/([^/]+)\.sql$'), (match) => match.group(1)!))
        .where((path) => !path.contains('/'))
        .toList();

    for (var endpoint in endpoints) {
      await _createTable(db, endpoint);
    }
  }

  Future<void> _reset(String table) async {
    await _createTable(_database, table);
  }

  Future<void> _createTable(Database db, String table) async {
    final rawSQLString = await rootBundle.loadString('assets/database/$table.sql');
    final sqlQueries = rawSQLString //
        .trim()
        .split(';')
        .map((query) => query.trim())
        .where((query) => query.isNotEmpty);

    for (var query in sqlQueries) {
      await db.execute(query);
    }
  }
}
