import 'package:flutter/material.dart';
import 'package:orderbook/data/local/storage.dart';

class AppModel extends ChangeNotifier {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    AppStorage.storageWrite(key: AppStorage.themeKEY,value: value);
    notifyListeners();
  }

}