import 'package:equatable/equatable.dart';
import 'package:movies_list/data/models/movie.dart';

class MovieDetailsState extends Equatable {
  final bool isLoading;
  final Movie? movie;
  final bool watched;

  const MovieDetailsState(
    this.watched, {
    this.isLoading = true,
    this.movie,
  });

  copyWith({
    bool? isLoading,
    Movie? movie,
    bool? watched,
  }) {
    return MovieDetailsState(
      watched ?? this.watched,
      isLoading: isLoading ?? this.isLoading,
      movie: movie ?? this.movie,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        movie,
        watched,
      ];
}
