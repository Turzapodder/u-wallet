import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static final SharedPreferenceHelper _instance =
  SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() => _instance;

  SharedPreferences? _preferences;

  SharedPreferenceHelper._internal();

  Future<void> initialize() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  String? getValue() {
    return _preferences?.getString('userTypeKey');
  }

}
