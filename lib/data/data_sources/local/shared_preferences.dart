import 'package:movie_marks/constants/shared_preferences_key.dart';
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

  Future<void> setUserToken(String value) async {
    await _prefsInstance.setString(SharedPreferencesKey.token, value);
  }

  String getUserToken() {
    return _prefsInstance.getString(SharedPreferencesKey.token) ?? "";
  }

  Future<void> setAvatar(String value) async {
    await _prefsInstance.setString(SharedPreferencesKey.avatar, value);
  }

  String getAvatar() {
    return _prefsInstance.getString(SharedPreferencesKey.avatar) ?? "";
  }

  Future<void> setUserId(String value) async {
    await _prefsInstance.setString(SharedPreferencesKey.idUser, value);
  }

  String getUserId() {
    return _prefsInstance.getString(SharedPreferencesKey.idUser) ?? "";
  }

  Future<void> setUsername(String value) async {
    await _prefsInstance.setString(SharedPreferencesKey.username, value);
  }

  String getUsername() {
    return _prefsInstance.getString(SharedPreferencesKey.username) ?? "";
  }

  Future<void> setEmailUser(String value) async {
    await _prefsInstance.setString(SharedPreferencesKey.email, value);
  }

  String getEmailUser() {
    return _prefsInstance.getString(SharedPreferencesKey.email) ?? "";
  }
}
