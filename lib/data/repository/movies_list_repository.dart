import 'package:movies_list/data/api/movies_api_service.dart';
import 'package:movies_list/data/models/movie.dart';
import 'package:movies_list/data/models/pagination_response.dart';
import 'package:movies_list/data/local_storage/movies_cache.dart';

class MoviesListRepository {
  final MoviesApiService _moviesListApi;
  final MoviesCache _cache;

  MoviesListRepository(this._moviesListApi, this._cache);

  Future<PaginationResponse<List<Movie>>> getTopRatedMovies(int page) async {
    final cachedMovies = _checkCache(page);

    if (cachedMovies != null) {
      return Future.value(cachedMovies);
    }

    final response = await _moviesListApi.getTopRatedMovies(page);
    final localMovies = response.results.map((m) => m.toLocalModel()).toList();

    _cache.saveNewMovies(
      localMovies,
      page,
      response.totalPages,
      response.totalResults,
    );

    final result = PaginationResponse<List<Movie>>(
      page: page,
      results: localMovies,
      totalPages: response.totalPages,
      totalResults: response.totalResults,
    );

    return Future.value(result);
  }

  PaginationResponse<List<Movie>>? _checkCache(int page) {
    final cachedMovies = _cache.movies;

    if (cachedMovies.isNotEmpty && page <= _cache.lastFetchedPage) {
      return PaginationResponse<List<Movie>>(
        page: _cache.lastFetchedPage,
        results: cachedMovies,
        totalPages: _cache.totalPages,
        totalResults: _cache.totalResults,
      );
    } else {
      return null;
    }
  }
}
