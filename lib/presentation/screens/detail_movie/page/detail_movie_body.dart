import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/data/models/movie_model.dart';
import 'package:movie_marks/presentation/components/custom_scrollable_tab.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_bloc.dart';
import 'package:movie_marks/presentation/screens/detail_movie/bloc/detail_movie_state.dart';
import 'package:movie_marks/presentation/screens/detail_movie/widgets/app_bar_detail_movie.dart';

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
        if (state.status == DetailMovieStatus.initial) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
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
                  // List of genres
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final genres = state.movieModel?.genres ?? [];
                        return Container(
                          margin: const EdgeInsets.only(top: 18, bottom: 8),
                          height: 32,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: genres.length,
                            itemBuilder: (context, index) {
                              final item = genres[index];
                              return Container(
                                margin:
                                    EdgeInsets.only(left: index == 0 ? 29 : 0),
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
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                  // ScrollableListTabScroller
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const CustomScrollableTab(
                        indicatorInsets: EdgeInsets.symmetric(horizontal: 10),
                        data: {
                          'Tab 1': [
                            Column(
                              children: [
                                Text('Item 1 in Tab 1'),
                                Icon(Icons.star),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Item 2 in Tab 1'),
                                Icon(Icons.favorite),
                              ],
                            ),
                          ],
                          'Tab 2': [
                            Column(
                              children: [
                                Text('Item 1 in Tab 2'),
                                Icon(Icons.access_alarm),
                              ],
                            ),
                          ],
                          'Tab 3': [
                            Column(
                              children: [
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                              ],
                            ),
                          ],
                          'Tab 4': [
                            Column(
                              children: [
                                Text('Item 1 in Tab 1'),
                                Icon(Icons.star),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Item 2 in Tab 1'),
                                Icon(Icons.favorite),
                              ],
                            ),
                          ],
                          'Tab 5': [
                            Column(
                              children: [
                                Text('Item 1 in Tab 2'),
                                Icon(Icons.access_alarm),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                              ],
                            ),
                          ],
                          'Tab 6': [
                            Column(
                              children: [
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                                Text('Item 1 in Tab 3'),
                                Icon(Icons.accessibility),
                              ],
                            ),
                          ],
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
