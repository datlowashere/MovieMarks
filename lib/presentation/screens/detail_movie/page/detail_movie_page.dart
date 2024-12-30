import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_event.dart';
import 'package:movie_marks/presentation/screens/detail_movie/page/detail_movie_body.dart';

class DetailMoviePage extends StatelessWidget {
  final MovieModel? movieModel;

  const DetailMoviePage({super.key, this.movieModel});

  @override
  Widget build(BuildContext context) {
    final bool isLoadingPage =
        ModalRoute.of(context)?.settings.arguments as bool? ?? true;
    return BlocProvider<DetailMovieBloc>(
      create: (context) => DetailMovieBloc()
        ..add(DetailMovieInitialEvent(
            isLoadingPage: isLoadingPage,
            movieModel: movieModel ?? MovieModel())),
      child: const DetailMovieBody(),
    );
  }
}
