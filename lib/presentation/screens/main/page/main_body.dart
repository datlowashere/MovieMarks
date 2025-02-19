import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/screens/home/page/home_page.dart';
import 'package:movie_marks/presentation/screens/main/bloc/main_bloc.dart';
import 'package:movie_marks/presentation/screens/main/bloc/main_state.dart';
import 'package:movie_marks/presentation/screens/settings/page/setting_page.dart';
import 'package:movie_marks/presentation/screens/watch_list/page/watch_list_page.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  int _selectedIndex = 0;

  final List<Widget> tabItems = [
    const HomePage(),
    const WatchListPage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) {},
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Scaffold(
            body: tabItems[_selectedIndex],
            bottomNavigationBar: SizedBox(
              child: FlashyTabBar(
                animationCurve: Curves.easeInOut,
                selectedIndex: _selectedIndex,
                iconSize: 30,
                showElevation: false,
                onItemSelected: (index) => setState(() {
                  _selectedIndex = index;
                }),
                backgroundColor: AppColors.charlestonGreen,
                items: [
                  FlashyTabBarItem(
                      icon: const Icon(Icons.home),
                      title: Text(
                        AppConstants.home,
                        style: AppTextStyles.beVietNamProStyles.bold14White,
                      ),
                      activeColor: AppColors.brightGray,
                      inactiveColor: AppColors.brightGray),
                  FlashyTabBarItem(
                      icon: const Icon(Icons.bookmark),
                      title: Text(
                        AppConstants.watchList,
                        style: AppTextStyles.beVietNamProStyles.bold14White,
                      ),
                      activeColor: AppColors.brightGray,
                      inactiveColor: AppColors.brightGray),
                  FlashyTabBarItem(
                      icon: const Icon(Icons.settings),
                      title: Text(
                        AppConstants.settings,
                        style: AppTextStyles.beVietNamProStyles.bold14White,
                      ),
                      activeColor: AppColors.brightGray,
                      inactiveColor: AppColors.brightGray),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
