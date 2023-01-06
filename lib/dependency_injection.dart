import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/client.dart';
import 'core/api/mock.dart';
import 'core/api/request_interceptor.dart';
import 'core/api/response_interceptor.dart';
import 'core/api/token.dart';
import 'core/routing/routing.dart';
import 'core/theme/theme.dart';
import 'features/counter/data/datasources/remote/data_source.dart';
import 'features/counter/data/repositories/repository.dart';
import 'features/counter/domain/use_cases/decrement.dart';
import 'features/counter/domain/use_cases/delete.dart';
import 'features/counter/domain/use_cases/get_counter.dart';
import 'features/counter/domain/use_cases/get_counters.dart';
import 'features/counter/domain/use_cases/increment.dart';
import 'features/counter/domain/use_cases/reset.dart';
import 'features/counter/domain/use_cases/reset_database_table.dart';
import 'features/counter/presentation/detail/bloc/bloc.dart';
import 'features/counter/presentation/list/bloc/bloc.dart';
import 'features/login/data/datasources/remote/data_source.dart';
import 'features/login/data/repositories/repository.dart';
import 'features/login/domain/use_cases/login.dart';
import 'features/login/domain/use_cases/save_token.dart';
import 'features/login/presentation/bloc/bloc.dart';
import 'features/logout/domain/use_cases/delete_token.dart';
import 'features/logout/presentation/bloc/bloc.dart';
import 'features/settings/data/datasources/local/data_source.dart';
import 'features/settings/data/repositories/repository.dart';
import 'features/settings/domain/use_cases/get_language_code.dart';
import 'features/settings/domain/use_cases/get_settings.dart';
import 'features/settings/domain/use_cases/set_house_number.dart';
import 'features/settings/domain/use_cases/set_language_code.dart';
import 'features/settings/domain/use_cases/set_theme_mode.dart';
import 'features/settings/presentation/bloc/bloc.dart';

class DependencyInjection {
  final di = GetIt.instance;

  Future<void> init() async {
    await di.reset();

    // external
    final sharedPreferences = await SharedPreferences.getInstance();
    di.registerLazySingleton(() => sharedPreferences);

    await Hive.initFlutter();
    final hive = await Hive.openBox('app');
    di.registerLazySingleton(() => hive);

    di.registerLazySingleton(() => Dio());

    /// core
    di.registerLazySingleton(() => GlobalKey<ScaffoldMessengerState>());
    di.registerLazySingleton(() => AppTheme());
    di.registerLazySingleton(() => AppRouting(di()));

    /// core, Api
    final apiMock = AppApiMock();
    await apiMock.init();
    di.registerLazySingleton(() => apiMock);
    di.registerLazySingleton(() => AppApiToken(di()));
    di.registerLazySingleton(() => AppApiResponseInterceptor());
    di.registerLazySingleton(() => AppApiRequestInterceptor(di()));
    di.registerLazySingleton(() => AppApiClient(di(), di(), di(), di(), di()));

    // login
    di.registerFactory(() => LoginBloc(di()));
    di.registerLazySingleton(() => LoginRemoteDataSource(di()));
    di.registerLazySingleton(() => LoginRepository(di()));
    di.registerLazySingleton(() => LoginUseCaseLogin(di(), di()));
    di.registerLazySingleton(() => LoginUseCaseSaveToken(di()));

    // logout
    di.registerFactory(() => LogoutBloc(di()));
    di.registerLazySingleton(() => LogoutUseCaseDeleteToken(di()));

    // settings
    di.registerFactory(() => SettingsBloc(di(), di(), di(), di()));
    di.registerLazySingleton(() => SettingsLocalDataSource(di()));
    di.registerLazySingleton(() => SettingsRepository(di()));
    di.registerLazySingleton(() => SettingsUseCaseGetSettings(di()));
    di.registerLazySingleton(() => SettingsUseCaseGetLanguageCode(di()));
    di.registerLazySingleton(() => SettingsUseCaseSetLanguageCode(di()));
    di.registerLazySingleton(() => SettingsUseCaseSetThemeMode(di()));
    di.registerLazySingleton(() => SettingsUseCaseSetHouseNumber(di()));

    // counter
    di.registerFactory(() => CounterListBloc(di(), di()));
    di.registerFactory(() => CounterDetailBloc(di(), di(), di(), di(), di()));
    di.registerLazySingleton(() => CounterRemoteDataSource(di()));
    di.registerLazySingleton(() => CounterRepository(di()));
    di.registerLazySingleton(() => CounterUseCaseGetCounters(di()));
    di.registerLazySingleton(() => CounterUseCaseGetCounter(di()));
    di.registerLazySingleton(() => CounterUseCaseIncrement(di()));
    di.registerLazySingleton(() => CounterUseCaseDecrement(di()));
    di.registerLazySingleton(() => CounterUseCaseReset(di()));
    di.registerLazySingleton(() => CounterUseCaseResetDatabaseTable(di()));
    di.registerLazySingleton(() => CounterUseCaseDelete(di()));
  }
}
