import 'dart:async';

import 'package:movies_list/data/models/movie.dart';

class MoviesCache {
  MoviesCache();

  final List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  int _lastFetchedPage = 0;

  int get lastFetchedPage => _lastFetchedPage;

  int _totalPages = 0;

  int get totalPages => _totalPages;

  int _totalResults = 0;

  int get totalResults => _totalResults;

  int get watchedMoviesAmount => _movies.where((m) => m.watched).length;

  final StreamController<int> _watchedMoviesStreamController =
      StreamController<int>.broadcast();

  Stream<int> get watchedMoviesStream => _watchedMoviesStreamController.stream;

  void saveNewMovies(
    List<Movie> movies,
    int page,
    int totalPages,
    int totalResults,
  ) {
    _movies.addAll(movies);
    _lastFetchedPage = page;
    _totalPages = totalPages;
    _totalResults = totalResults;
  }

  Movie getMovieDetailsById(int id) {
    return _movies.firstWhere((m) => m.id == id);
  }

  void toggleMovieWatched(Movie movie, bool watched) {
    _movies.firstWhere((m) => m.id == movie.id).watched = watched;
    _emitWatchedMoviesAmount();
  }

  void _emitWatchedMoviesAmount() {
    _watchedMoviesStreamController.add(watchedMoviesAmount);
  }

  void dispose() {
    _watchedMoviesStreamController.close();
  }
}
