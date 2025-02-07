import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/presentation/components/custom_title.dart';
import 'package:movie_marks/presentation/components/movie_item.dart';
import 'package:movie_marks/presentation/screens/detail_movie/page/detail_movie_page.dart';
import 'package:movie_marks/presentation/screens/search/bloc/search_bloc.dart';
import 'package:movie_marks/presentation/screens/search/bloc/search_event.dart';
import 'package:movie_marks/presentation/screens/search/bloc/search_state.dart';
import 'package:movie_marks/presentation/screens/search/widgets/appbar_search.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        state.status == SearchStatus.processing
            ? EasyLoading.show()
            : EasyLoading.dismiss();
      },
      child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.charlestonGreen,
          body: SafeArea(
              child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                AppbarSearch(
                  searchValue: state.searchValue ?? "",
                  onChangeSearch: (value) {
                    context
                        .read<SearchBloc>()
                        .add(SearchValueChangedEvent(searchValue: value));
                  },
                  onTapBack: () {
                    Navigator.of(context).pop();
                  },
                  onTapSearch: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTitle(
                  title: (state.searchValue?.isEmpty ?? true)
                      ? ""
                      : "Total ${state.searchModel?.totalResults} result for: ${state.searchValue}",
                  isFullWidth: true,
                  padding: const EdgeInsets.only(left: 29),
                  style: AppTextStyles.beVietNamProStyles.regular14White,
                ),
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: LazyLoadScrollView(
                    onEndOfPage: () {
                      context.read<SearchBloc>().add(SearchLoadMoreEvent());
                    },
                    isLoading: state.isLoadingMore,
                    child: Container(
                      margin: const EdgeInsets.only(left: 29),
                      child: ListView.separated(
                        addAutomaticKeepAlives: true,
                        itemCount: state.searchModel?.movies?.length ?? 0,
                        itemBuilder: (context, index) {
                          final movie = state.searchModel?.movies?[index];
                          return MovieItem(
                            index: index,
                            movieModel: movie,
                            isShowActionRow: false,
                            onTapMovie: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailMoviePage(
                                    movieId: movie?.id,
                                    isSaved: movie?.isSaved,
                                  ),
                                ),
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
                const SizedBox(
                  height: 8,
                ),
                CustomTitle(
                  title: (state.searchValue?.isEmpty ?? true)
                      ? ""
                      : "Page ${state.searchModel?.page} of ${state.searchModel?.totalPages}",
                  isFullWidth: true,
                  padding: const EdgeInsets.only(left: 29),
                  style: AppTextStyles.beVietNamProStyles.regular14White,
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
