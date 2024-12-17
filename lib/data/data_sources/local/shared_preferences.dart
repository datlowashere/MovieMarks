import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefer {
  static final SharedPrefer sharedPrefer = SharedPrefer._internal();

  factory SharedPrefer() {
    return sharedPrefer;
  }

  SharedPrefer._internal();

  late SharedPreferences _prefsInstance;

  Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }
}
