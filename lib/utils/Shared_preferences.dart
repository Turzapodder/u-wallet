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
  String? getPhone() {
    return _preferences?.getString('userPhoneKey');
  }
  String? getUID() {
    return _preferences?.getString('userUidKey');
  }
  String? getName() {
    return _preferences?.getString('userNameKey');
  }
  String? getFatherName() {
    return _preferences?.getString('userFatherKey');
  }
  String? getMotherName() {
    return _preferences?.getString('userMotherKey');
  }
  String? getNID() {
    return _preferences?.getString('userNidKey');
  }
  String? getNational() {
    return _preferences?.getString('userNationalKey');
  }
  String? getPassword() {
    return _preferences?.getString('userPasswordKey');
  }
  String? getAddress() {
    return _preferences?.getString('userAddressKey');
  }
  Future<String?> retrieveImagePath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('imagePath');
  }

  String? getUserName() {
    return _preferences?.getString('name');
  }
  String? getUserPhone() {
    return _preferences?.getString('phoneNumber');
  }
  String? getBalance() {
    return _preferences?.getString('balance');
  }
  String? getProfile() {
    return _preferences?.getString('profilePicUrl');
  }



}
