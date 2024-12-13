import 'package:equatable/equatable.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();
}

final class FetchMoviesEvent extends MoviesEvent {
  const FetchMoviesEvent();

  @override
  String toString() => 'FetchMoviesEvent';

  @override
  List<Object?> get props => [];
}
