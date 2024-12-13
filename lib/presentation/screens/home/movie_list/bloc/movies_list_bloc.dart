import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/data/models/movie.dart';
import 'package:movies_list/data/repository/movies_list_repository.dart';
import 'package:movies_list/presentation/screens/home/movie_list/bloc/movies_list_event.dart';
import 'package:movies_list/presentation/screens/home/movie_list/bloc/movies_list_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  int _page = 0;
  List<Movie> movies = [];

  MoviesBloc(this._repository) : super(const MoviesState()) {
    on<FetchMoviesEvent>(_fetchMovies);
  }

  final MoviesListRepository _repository;

  Future<void> _fetchMovies(
    FetchMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    // _page++;
    final response = await _repository.getTopRatedMovies(++_page);

    if (response.results.isNotEmpty) {
      final updatedMovies = List<Movie>.from(state.movies)
        ..addAll(response.results);
      _page = response.page;

      emit(
        state.copyWith(
          isLoading: false,
          movies: updatedMovies,
          hasNextPage: _page < response.totalPages,
        ),
      );
    } else {
      emit(state.copyWith(isLoading: false, hasNextPage: false));
    }
  }
}
