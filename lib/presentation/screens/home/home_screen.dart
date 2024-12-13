import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_list/presentation/screens/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:movies_list/presentation/screens/home/dashboard/dashboard_screen.dart';
import 'package:movies_list/presentation/screens/home/movie_list/bloc/movies_list_bloc.dart';
import 'package:movies_list/presentation/screens/home/movie_list/movie_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Top Rated Movies'),
              Tab(text: 'Dashboard'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (_) => GetIt.I<MoviesBloc>(),
              child: const MoviesListScreen(),
            ),
            BlocProvider(
              create: (_) => GetIt.I<DashboardCubit>()..getWatchedStatistics(),
              child: const DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
