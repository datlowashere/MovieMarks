import 'package:flutter/material.dart';
import 'package:movie_marks/presentation/screens/main/page/main_page.dart';

class AppRoutes {
  static const String main = '/home';

  static getInitialRoute() {
    return '/';
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (BuildContext context) => const MainPage(),
      main: (BuildContext context) => const MainPage(),
    };
  }
}
