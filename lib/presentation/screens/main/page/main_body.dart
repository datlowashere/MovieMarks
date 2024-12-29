import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_marks/constants/app_contants.dart';
import 'package:movie_marks/presentation/screens/home/page/home_page.dart';
import 'package:movie_marks/presentation/screens/main/bloc/main_bloc.dart';
import 'package:movie_marks/presentation/screens/main/bloc/main_state.dart';
import 'package:movie_marks/presentation/screens/settings/page/setting_page.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  int _selectedIndex = 0;

  final List<Widget> tabItems = [
    const HomePage(),
    const Center(child: Text("Bookmark Page")),
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
            bottomNavigationBar: FlashyTabBar(
              animationCurve: Curves.easeInOut,
              selectedIndex: _selectedIndex,
              iconSize: 30,
              showElevation: false,
              onItemSelected: (index) => setState(() {
                _selectedIndex = index;
              }),
              items: [
                FlashyTabBarItem(
                  icon: const Icon(Icons.home),
                  title: const Text(AppConstants.home),
                ),
                FlashyTabBarItem(
                  icon: const Icon(Icons.bookmark),
                  title: const Text(AppConstants.watchList),
                ),
                FlashyTabBarItem(
                  icon: const Icon(Icons.settings),
                  title: const Text(AppConstants.settings),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
