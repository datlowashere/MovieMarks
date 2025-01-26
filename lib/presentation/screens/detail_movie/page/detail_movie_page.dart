import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_event.dart';
import 'package:movie_marks/presentation/screens/detail_movie/page/detail_movie_body.dart';

class DetailMoviePage extends StatelessWidget {
  final int? movieId;
  final bool? isSaved;

  const DetailMoviePage({super.key, this.movieId, this.isSaved});

  @override
  Widget build(BuildContext context) {
    final bool isLoadingPage =
        ModalRoute.of(context)?.settings.arguments as bool? ?? true;
    return BlocProvider<DetailMovieBloc>(
      create: (context) => DetailMovieBloc()
        ..add(DetailMovieInitialEvent(
            isLoadingPage: isLoadingPage,
            movieId: movieId ?? 0,
            isSaved: isSaved ?? false)),
      child: const DetailMovieBody(),
    );
  }
}
