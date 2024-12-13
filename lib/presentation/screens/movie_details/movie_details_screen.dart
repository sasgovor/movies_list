import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:movies_list/presentation/screens/movie_details/cubit/movie_details_cubit.dart';
import 'package:movies_list/presentation/screens/movie_details/cubit/movies_details_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;

  const MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<MovieDetailsCubit>()..getMovieDetails(id),
      child: const _MovieDetailsContent(),
    );
  }
}

class _MovieDetailsContent extends StatelessWidget {
  const _MovieDetailsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        if (state.movie == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final movie = state.movie!;
        final String formattedDate = DateFormat('y MMM d').format(movie.releaseDate);
        return Scaffold(
          appBar: AppBar(title: Text(movie.title)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${movie.title}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(
                  'Release date: $formattedDate',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text(
                  'Overview: ${movie.overview}',
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Have you seen this movie?',
                        style: TextStyle(fontSize: 14)),
                    Checkbox(
                      value: movie.watched,
                      onChanged: (checked) {
                        if (checked != null) {
                          context
                              .read<MovieDetailsCubit>()
                              .toggleWatched(checked);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
