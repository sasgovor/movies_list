import 'package:dio/dio.dart';
import 'package:movies_list/data/models/movie_remote_model.dart';
import 'package:movies_list/data/models/pagination_response.dart';

class MoviesApiService {
  MoviesApiService(this._dio);

  final Dio _dio;

  Future<PaginationResponse<List<MovieRemoteModel>>> getTopRatedMovies(int page) async {
    final response = await _dio.get(
      'movie/top_rated',
      queryParameters: {
        'page': '$page',
      },
    );

    final results = response.data['results'] as List<dynamic>;
    final movies = results.map((e) => MovieRemoteModel.fromJson(e as Map<String, dynamic>)).toList();

    return PaginationResponse<List<MovieRemoteModel>>.fromJson(response.data, movies);
  }
}
