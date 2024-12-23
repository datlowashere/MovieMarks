import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movie_marks/presentation/routes/app_route.dart';

import 'config/app_config.dart';
import 'config/app_config_loading.dart';

void main() async {
  await AppConfig.init();
  runApp(const MyApp());
  AppConfigLoading.configLoading();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      builder: (context, child) {
        final width = MediaQuery.of(context).size.width;
        double textScaleFactor;
        if (width < 400) {
          textScaleFactor = 0.8;
        } else {
          textScaleFactor = 1.0;
        }
        return FlutterEasyLoading(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(textScaleFactor),
              devicePixelRatio: 1.0,
            ),
            child: child!,
          ),
        );
      },
      initialRoute: AppRoutes.getInitialRoute(),
      routes: AppRoutes.getRoutes(),
    );
  }
}
