import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_list/common/consts.dart';
import 'package:movies_list/data/api/movies_api_service.dart';
import 'package:movies_list/data/local_storage/movies_cache.dart';
import 'package:movies_list/data/repository/movies_list_repository.dart';
import 'package:movies_list/presentation/screens/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:movies_list/presentation/screens/home/movie_list/bloc/movies_list_bloc.dart';
import 'package:movies_list/presentation/screens/movie_details/cubit/movie_details_cubit.dart';

class DI {
  void setupDependencies() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<Dio>(() => _setupDio());
    getIt.registerLazySingleton(() => MoviesCache());

    getIt.registerLazySingleton(() => MoviesApiService(getIt<Dio>()));
    getIt.registerLazySingleton(
      () => MoviesListRepository(
        getIt<MoviesApiService>(),
        getIt<MoviesCache>(),
      ),
    );
    getIt.registerFactory(() => MoviesBloc(getIt<MoviesListRepository>()));
    getIt.registerFactory(() => MovieDetailsCubit(getIt<MoviesCache>()));
    getIt.registerFactory(() => DashboardCubit(getIt<MoviesCache>()));
  }

  Dio _setupDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: kBaseUrl,
        headers: {
          'Authorization': 'Bearer $kAccessToken',
          'accept': 'application/json'
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        logPrint: (o) => debugPrint(o.toString()),
      ),
    );

    return dio;
  }
}
