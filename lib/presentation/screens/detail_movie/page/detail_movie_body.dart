import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/app_bar_detail_movie.dart';

class DetailMovieBody extends StatefulWidget {
  const DetailMovieBody({super.key});

  @override
  State<DetailMovieBody> createState() => _DetailMovieBodyState();
}

class _DetailMovieBodyState extends State<DetailMovieBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailMovieBloc, DetailMovieState>(
      listener: (context, state) {
        state.status == DetailMovieStatus.initial
            ? EasyLoading.show()
            : EasyLoading.dismiss();
      },
      child: BlocBuilder<DetailMovieBloc, DetailMovieState>(
          builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.charlestonGreen,
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  AppBarDetailMovie(
                    movieModel: state.movieModel ?? MovieModel(),
                    onTapBack: Navigator.of(context).pop,
                    onTapBookMark: () {},
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          leading: Icon(Icons.star),
                          title: Text('Item $index'),
                        );
                      },
                      childCount: 30,
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
