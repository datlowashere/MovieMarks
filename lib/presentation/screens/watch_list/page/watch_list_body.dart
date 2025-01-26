import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/components/movie_item.dart';
import 'package:movie_marks/presentation/screens/detail_movie/page/detail_movie_page.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_bloc.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_event.dart';
import 'package:movie_marks/presentation/screens/watch_list/bloc/watch_list_state.dart';

class WatchListBody extends StatefulWidget {
  const WatchListBody({super.key});

  @override
  State<WatchListBody> createState() => _WatchListBody();
}

class _WatchListBody extends State<WatchListBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.charlestonGreen,
        body: BlocListener<WatchListBloc, WatchListState>(
          listener: (context, state) {
            state.status == WatchListStatus.processing
                ? EasyLoading.show()
                : EasyLoading.dismiss();
          },
          child: BlocBuilder<WatchListBloc, WatchListState>(
              builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  CustomTitle(
                    title: AppConstants.watchList,
                    style: AppTextStyles.beVietNamProStyles.semiBold18White,
                    margin: const EdgeInsets.symmetric(horizontal: 29)
                        .copyWith(left: 29),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  state.listMovies?.isEmpty ?? true
                      ? Expanded(
                          child: Center(
                            child: CustomTitle(
                              title: AppConstants.emptyMovie,
                              style: AppTextStyles
                                  .beVietNamProStyles.regular14White,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Expanded(
                          child: LazyLoadScrollView(
                            onEndOfPage: () {
                              context
                                  .read<WatchListBloc>()
                                  .add(WatchListLoadMoreEvent());
                            },
                            isLoading:
                                state.status == WatchListStatus.processing,
                            child: Container(
                              margin: const EdgeInsets.only(left: 29),
                              child: ListView.separated(
                                addAutomaticKeepAlives: true,
                                itemCount: state.listMovies?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final movie = state.listMovies?[index];
                                  return MovieItem(
                                    index: index,
                                    movieModel: movie,
                                    onTapMovie: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetailMoviePage(
                                            movieId: movie?.id,
                                            isSaved: movie?.isSaved,
                                          ),
                                        ),
                                      ).then((updatedMovieModel) {
                                        if (updatedMovieModel != null &&
                                            updatedMovieModel is MovieModel) {
                                          context.read<WatchListBloc>().add(
                                              WatchListUpdateMovieEvent(
                                                  updatedMovieModel));
                                        }
                                      });
                                    },
                                    onTapBookmark: () {
                                      context.read<WatchListBloc>().add(
                                          WatchListDeleteMovieEvent(
                                              idMovie: movie?.id ?? 0));
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 12);
                                },
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            );
          }),
        ));
  }
}
