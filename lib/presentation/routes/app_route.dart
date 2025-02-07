import 'package:flutter/material.dart';
import 'package:movie_marks/presentation/screens/auth/login/page/login_page.dart';
import 'package:movie_marks/presentation/screens/auth/register/page/register_page.dart';
import 'package:movie_marks/presentation/screens/detail_movie/page/detail_movie_page.dart';
import 'package:movie_marks/presentation/screens/main/page/main_page.dart';
import 'package:movie_marks/presentation/screens/search/page/search_page.dart';

class AppRoutes {
  static const String main = '/home';
  static const String detailMovie = '/detail-movie';
  static const String login = '/login';
  static const String register = '/register';
  static const String search = '/search';

  static getInitialRoute() {
    return '/';
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (BuildContext context) => const MainPage(),
      main: (BuildContext context) => const MainPage(),
      detailMovie: (BuildContext context) => const DetailMoviePage(),
      login: (BuildContext context) => const LoginPage(),
      register: (BuildContext context) => const RegisterPage(),
      search: (BuildContext context) => const SearchPage()
    };
  }
}
