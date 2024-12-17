import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_marks/data/data_sources/local/shared_preferences.dart';

import 'firebase_option.dart';

class AppConfig {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await SharedPrefer().init();
  }
}