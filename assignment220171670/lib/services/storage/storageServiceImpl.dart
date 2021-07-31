import 'package:shared_preferences/shared_preferences.dart';

import './storageService.dart';

/*
 This class is the concrete implementation of [StorageService].
 Shared preferences is used to save and retrieve data.
*/
class StorageServiceImpl implements StorageService {
  static const _isLoggedInKey = 'isLoggedIn';
  static const _nameKey = 'name';
  static const _idNumberKey = 'idNumber';

  @override
  Future<bool> getLoginData() {
    return _getBoolFromPreferences(_isLoggedInKey);
  }

  @override
  Future<String> getName() {
    return _getStringFromPreferences(_nameKey);
  }

  @override
  Future<String> getIdNumber() {
    return _getStringFromPreferences(_idNumberKey);
  }

  @override
  Future saveLoginData(bool isLoggedIn) {
    return _saveBoolToPreferences(_isLoggedInKey, isLoggedIn);
  }

  @override
  Future saveName(String name) {
    return _saveStringToPreferences(_nameKey, name);
  }

  Future saveIdNumber(String idNumber) {
    return _saveStringToPreferences(_idNumberKey, idNumber);
  }

  Future<bool> _getBoolFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<bool>.value(prefs.getBool(key) ?? false);
  }

  Future<String> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  Future<void> _saveBoolToPreferences(String key, bool data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, data);
  }

  Future<void> _saveStringToPreferences(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }
}
