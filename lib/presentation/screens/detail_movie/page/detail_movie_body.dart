import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/app_bar_detail_movie.dart';

import '../../../../config/theme/app_text_styles.dart';
import '../../../components/custom_button.dart';

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
                        return Column(
                          children: [
                            Container(
                              height: 32,
                              margin: const EdgeInsets.only(top: 18, bottom: 8),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.movieModel?.genres?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final item = state.movieModel?.genres?[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 29 : 0),
                                    child: CustomButton(
                                      onTap: () {},
                                      title: item?.title ?? "",
                                      titleStyle: AppTextStyles
                                          .beVietNamProStyles.regular12White,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 22),
                                      backgroundColor: AppColors.arsenic,
                                      borderRadius: 16,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(width: 12);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
