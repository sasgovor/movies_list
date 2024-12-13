import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movies_list/data/models/movie.dart';
import 'package:movies_list/presentation/screens/home/movie_list/bloc/movies_list_bloc.dart';
import 'package:movies_list/presentation/screens/home/movie_list/bloc/movies_list_event.dart';
import 'package:movies_list/presentation/screens/home/movie_list/bloc/movies_list_state.dart';
import 'package:movies_list/presentation/screens/movie_details/movie_details_screen.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.isLoading) {
          context.read<MoviesBloc>().add(const FetchMoviesEvent());
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: state.movies.length + (state.hasNextPage ? 1 : 0),
          itemBuilder: (context, index) {

            if (index == state.movies.length && state.hasNextPage) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _loadMoreMoviesButton(
                  onTap: () =>
                      context.read<MoviesBloc>().add(const FetchMoviesEvent()),
                ),
              );
            }

            final movie = state.movies[index];
            return _movieItem(
              movie: movie,
              index: index + 1,
              onTap: () => _openMovieDetails(context, movie.id),
            );
          },
        );
      },
    );
  }

  Widget _movieItem({
    required Movie movie,
    required VoidCallback onTap,
    required int index,
  }) {

    return ListTile(
      title: Text('# $index. ${movie.title}'),
      subtitle: Text('${movie.releaseDate.year}'),
      trailing: Text('Rating: ${movie.voteAverage}'),
      onTap: () => onTap(),
    );
  }

  Widget _loadMoreMoviesButton({required VoidCallback onTap}) {
    return FilledButton(
      onPressed: () => onTap(),
      child: const Text('More movies'),
    );
  }

  void _openMovieDetails(BuildContext context, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailsScreen(id: id),
      ),
    );
  }
}
