import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/components/custom_button.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/components/dialog_login_request.dart';
import 'package:movie_marks/presentation/components/movie_item.dart';
import 'package:movie_marks/presentation/routes/app_route.dart';
import 'package:movie_marks/presentation/screens/detail_movie/page/detail_movie_page.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_bloc.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_event.dart';
import 'package:movie_marks/presentation/screens/home/bloc/home_state.dart';
import 'package:movie_marks/presentation/screens/home/widgets/app_bar_home.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    final accessToken = SharedPrefer.sharedPrefer.getUserToken();
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        state.status == HomeStatus.processing
            ? EasyLoading.show()
            : EasyLoading.dismiss();
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.charlestonGreen,
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarHome(
                      onTapSearch: () {
                        Navigator.pushNamed(context, AppRoutes.search);
                      },
                      userModel: state.user,
                    ),
                    CustomTitle(
                      title: AppConstants.genreTitle,
                      style: AppTextStyles.beVietNamProStyles.semiBold18White,
                      margin: const EdgeInsets.symmetric(horizontal: 29),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 32,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.listGenres?.length ?? 0,
                        itemBuilder: (context, index) {
                          state.listGenres?[index];
                          return Container(
                            margin: EdgeInsets.only(left: index == 0 ? 29 : 0),
                            child: CustomButton(
                              title: state.listGenres?[index].title ?? '',
                              titleStyle: AppTextStyles
                                  .beVietNamProStyles.regular12White
                                  .copyWith(
                                color:
                                    state.listGenres?[index].isSelected ?? false
                                        ? AppColors.brightGray
                                        : Colors.white,
                                fontWeight:
                                    state.listGenres?[index].isSelected ?? false
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                              ),
                              backgroundColor:
                                  state.listGenres?[index].isSelected ?? false
                                      ? AppColors.eucalyptus
                                      : AppColors.arsenic,
                              onTap: () {
                                final genre = state.listGenres?[index];
                                if (genre != null) {
                                  context
                                      .read<HomeBloc>()
                                      .add(HomeGenreSelectionEvent(genre));
                                }
                              },
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 22),
                              borderRadius: 16,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 29);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 29,
                    ),
                    if (state.listMovies?.isEmpty ?? true)
                      Expanded(
                        child: Center(
                          child: CustomTitle(
                            title: AppConstants.emptyMovie,
                            style:
                                AppTextStyles.beVietNamProStyles.regular14White,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: LazyLoadScrollView(
                          onEndOfPage: () {
                            context
                                .read<HomeBloc>()
                                .add(HomeLoadMoreMoviesEvent());
                          },
                          isLoading: state.status == HomeStatus.processing,
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
                                  isShowReadMore: false,
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
                                        context.read<HomeBloc>().add(
                                            HomeUpdateMovieEvent(
                                                updatedMovieModel));
                                      }
                                    });
                                  },
                                  onTapBookmark: () {
                                    accessToken.isNotEmpty
                                        ? context.read<HomeBloc>().add(
                                            HomeToggleBookmarkEvent(
                                                movie ?? MovieModel()))
                                        : showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const DialogLoginRequest(),
                                          );
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
                  ]),
            )),
          );
        },
      ),
    );
  }
}
