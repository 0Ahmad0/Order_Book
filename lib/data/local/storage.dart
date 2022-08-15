import 'dart:math';

import 'package:get_storage/get_storage.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';

class AppStorage {
  static GetStorage _storage = GetStorage();
  static const themeKEY = "theme";
  static const languageKEY = "language";
  static const isLoginedKEY = "isLogin";
  static const avatarKEY = "avatar";
  static const nameKEY = "name";
  static const phoneNumberKEY = "phoneNumber";
  static const tokenKEY = "token";
  static const idKEY = "id";

  static init() async {
    if (!_storage.hasData(isLoginedKEY)) {
      storageWrite(key: isLoginedKEY, value: false);
    } else {
      Advance.isLogined = await storageRead(key: isLoginedKEY);
    }
    if (!_storage.hasData(languageKEY)) {
      storageWrite(key: languageKEY, value: true);
    } else {
      Advance.language = await storageRead(key: languageKEY);
    }
    if (!_storage.hasData(themeKEY)) {
      storageWrite(key: themeKEY, value: false);
    } else {
      Advance.theme = await storageRead(key: themeKEY);
      //print("a${Advance.theme}");
    }
    if (!_storage.hasData(avatarKEY)) {
      var valAvatar = ImagesAssets.avatarImages[Random().nextInt(
          ImagesAssets.avatarImages.length)];
      storageWrite(key: avatarKEY, value:valAvatar);
    } else {
      Advance.avatarImage = await storageRead(key: avatarKEY);
    }
  }

  static Future<void> storageWrite({key, value}) async =>
      await _storage.write(key, value);

  static Future<dynamic> storageRead({key}) async => await _storage.read(key);

  static Future<void> storageDelete({key}) async => await _storage.remove(key).then((value) => print("delete key successful"));
static depose() async {
  await _storage.remove(idKEY);
  await _storage.remove(phoneNumberKEY);
  await _storage.write(isLoginedKEY, false);
}

}