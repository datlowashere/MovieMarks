import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';
import 'package:movie_marks/data/models/external_ids_model.dart';
import 'package:movie_marks/data/models/movie_credits_model.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/data/models/review_data_model.dart';
import 'package:movie_marks/presentation/components/custom_tab_bar.dart';
import 'package:movie_marks/presentation/components/dialog_login_request.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_event.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/app_bar_detail_movie.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/bottom_sheet_write_review.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/cast_movie_tab.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/crew_movie_tab.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/overview_movie_tab.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/review_movie_tab.dart';

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
        state.status == DetailMovieStatus.processing
            ? EasyLoading.show()
            : EasyLoading.dismiss();
      },
      child: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          final accessToken = SharedPrefer.sharedPrefer.getUserToken();
          return state.status == DetailMovieStatus.processing
              ? Container(
                  color: AppColors.arsenic,
                )
              : PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (bool didPop, Object? result) {
                    if (!didPop) {
                      Navigator.of(context).pop(state.movieModel);
                    }
                  },
                  child: Scaffold(
                    backgroundColor: AppColors.charlestonGreen,
                    body: SafeArea(
                      child: CustomScrollView(
                        slivers: [
                          AppBarDetailMovie(
                            movieModel: state.movieModel ?? MovieModel(),
                            onTapBack: () {
                              Navigator.of(context).pop(state.movieModel);
                            },
                            onTapBookMark: () {
                              accessToken.isNotEmpty
                                  ? context.read<DetailMovieBloc>().add(
                                      DetailMovieToggleBookmarkEvent(
                                          state.movieModel ?? MovieModel(),
                                          state.reviewData?.reviews ?? []))
                                  : showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const DialogLoginRequest(),
                                    );
                            },
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
                                    state.movieModel?.tagline?.isNotEmpty ??
                                            true
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(left: 29),
                                            child: Text(
                                              "`${state.movieModel?.tagline}`",
                                              style: AppTextStyles
                                                  .beVietNamProStyles
                                                  .medium12White
                                                  .copyWith(
                                                      fontStyle:
                                                          FontStyle.italic),
                                            ))
                                        : const SizedBox.shrink(),
                                    genres.isNotEmpty
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                top: 18, bottom: 8),
                                            height: 32,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: genres.length,
                                              itemBuilder: (context, index) {
                                                final item = genres[index];
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          index == 0 ? 29 : 0),
                                                  child: CustomButton(
                                                    onTap: () {},
                                                    title: item.title ?? "",
                                                    titleStyle: AppTextStyles
                                                        .beVietNamProStyles
                                                        .regular14White,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 7,
                                                        horizontal: 22),
                                                    backgroundColor:
                                                        AppColors.arsenic,
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(width: 12),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 29),
                              child: CustomTabBar(
                                dividerColor: Colors.transparent,
                                indicatorColor: AppColors.brightGray,
                                tabsWithViews: {
                                  AppConstants.overview: OverviewMovieTab(
                                    movieModel:
                                        state.movieModel ?? MovieModel(),
                                    keywords: state.keywords ?? [],
                                    externalIdsModel: state.externalIdsModel ??
                                        ExternalIdsModel(),
                                  ),
                                  "${AppConstants.casts} (${state.movieCreditsModel?.cast.length})":
                                      CastMovieTab(
                                    movieCreditsModel: state
                                            .movieCreditsModel ??
                                        MovieCreditsModel(cast: [], crew: []),
                                  ),
                                  "${AppConstants.crew} (${state.movieCreditsModel?.crew.length})":
                                      CrewMovieTab(
                                    movieCreditsModel: state
                                            .movieCreditsModel ??
                                        MovieCreditsModel(cast: [], crew: []),
                                  ),
                                  AppConstants.reviews: ReviewMovieTab(
                                    reviewData: state.reviewData ??
                                        ReviewDataModel(
                                            averageRating: "", reviews: []),
                                    onTapWriteReview: () {
                                      accessToken.isNotEmpty
                                          ? showModalBottomSheet(
                                              context: context,
                                              barrierColor:
                                                  Colors.black.withOpacity(0.5),
                                              isScrollControlled: true,
                                              builder: (_) {
                                                return BottomSheetWriteReview(
                                                  onRatingUpdate: (rate) {
                                                    context
                                                        .read<DetailMovieBloc>()
                                                        .add(
                                                            DetailMovieRateEvent(
                                                                ratePoint:
                                                                    rate));
                                                  },
                                                  onChanged: (value) {
                                                    context
                                                        .read<DetailMovieBloc>()
                                                        .add(
                                                            DetailMovieReviewChangedEvent(
                                                                review: value));
                                                  },
                                                  onTapSubmit: () {
                                                    context
                                                        .read<DetailMovieBloc>()
                                                        .add(
                                                            DetailMovieSubmitRateEvent());
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              })
                                          : showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  const DialogLoginRequest(),
                                            );
                                    },
                                  ),
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
