import 'package:flutter/material.dart';
import 'package:movie_marks/presentation/screens/home/page/home_page.dart';

class AppRoutes {
  static const String home = '/home';

  static getInitialRoute() {
    return '/';
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (BuildContext context) => const HomePage(),
      home: (BuildContext context) => const HomePage(),
    };
  }
}
