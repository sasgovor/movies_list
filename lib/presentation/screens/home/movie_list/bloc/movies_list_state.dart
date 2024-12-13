import 'package:equatable/equatable.dart';
import 'package:movies_list/data/models/movie.dart';

class MoviesState extends Equatable {
  final bool isLoading;
  final List<Movie> movies;
  final bool hasNextPage;

  bool get hasMovies => movies.isNotEmpty;

  const MoviesState({
    this.isLoading = true,
    this.movies = const [],
    this.hasNextPage = true,
  });

  copyWith({
    bool? isLoading,
    List<Movie>? movies,
    bool? hasNextPage,
  }) {
    return MoviesState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      hasNextPage: hasNextPage ?? this.hasNextPage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        movies,
        hasNextPage,
      ];
}
