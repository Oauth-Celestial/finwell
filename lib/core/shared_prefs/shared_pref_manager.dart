import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPrefManager._();

  static final SharedPrefManager _instance = SharedPrefManager._();
  SharedPreferences? prefs;
  String catchUpStatus = "catchUp";

  factory SharedPrefManager() {
    return _instance;
  }

  initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveCatchScreenShow() {
    prefs?.setBool(catchUpStatus, true);
  }

  bool getCatchupStatus() {
    return prefs?.getBool(catchUpStatus) ?? false;
  }
}
