import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/external_ids_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/components/custom_tab_bar.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/app_bar_detail_movie.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/cast_movie_tab.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/crew_movie_tab.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/overview_movie_tab.dart';

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
                        final genres = state.movieModel?.genres ?? [];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Container(
                                margin: const EdgeInsets.only(left: 29),
                                child: Text(
                                  "`${state.movieModel?.tagline}`",
                                  style: AppTextStyles
                                      .beVietNamProStyles.medium12White
                                      .copyWith(fontStyle: FontStyle.italic),
                                )),
                            Container(
                              margin: const EdgeInsets.only(top: 18, bottom: 8),
                              height: 32,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: genres.length,
                                itemBuilder: (context, index) {
                                  final item = genres[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 29 : 0),
                                    child: CustomButton(
                                      onTap: () {},
                                      title: item.title ?? "",
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 22),
                                      backgroundColor: AppColors.arsenic,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 29),
                      child: CustomTabBar(
                        dividerColor: Colors.transparent,
                        indicatorColor: AppColors.brightGray,
                        tabsWithViews: {
                          AppConstants.overview: OverviewMovieTab(
                            movieModel: state.movieModel ?? MovieModel(),
                            keywords: state.keywords ?? [],
                            externalIdsModel: state.externalIdsModel ?? ExternalIdsModel(),
                          ),
                          AppConstants.casts: CastMovieTab(),
                          AppConstants.crew: CrewMovieTab(),
                          AppConstants.reviews:
                              Center(child: Text('Content for Tab 4')),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
