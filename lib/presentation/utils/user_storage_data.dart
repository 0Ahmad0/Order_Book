import 'package:get_storage/get_storage.dart';

class UserStorageData{
  static final _storage = GetStorage();

  static const _keyTheme = "theme";
  static Future setTheme(bool theme)  =>
      _storage.write(_keyTheme, theme);

  static  getTheme() async =>
     await _storage.read(_keyTheme);


}