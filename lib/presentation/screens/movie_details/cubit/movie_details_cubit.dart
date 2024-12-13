import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/data/local_storage/movies_cache.dart';
import 'package:movies_list/presentation/screens/movie_details/cubit/movies_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this._cache)
      : super(const MovieDetailsState(false, movie: null));

  final MoviesCache _cache;

  void getMovieDetails(int id) {
    final movie = _cache.getMovieDetailsById(id);
    emit(state.copyWith(isLoading: false, movie: movie));
  }

  void toggleWatched(bool watched) {
    final movie = state.movie!;
    movie.watched = watched;

    emit(state.copyWith(movie: movie, watched: watched));
    _cache.toggleMovieWatched(movie, watched);
  }
}
