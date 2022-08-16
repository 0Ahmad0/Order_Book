import 'package:flutter/material.dart';
import 'package:orderbook/data/local/storage.dart';

import '../../domain/models.dart';

class DataLocal{
  static User user = User();

  static Future<void> getData() async {
    user =User(
      name: await AppStorage.storageRead(key:AppStorage.nameKEY),
      phoneNumber: await AppStorage.storageRead(key:AppStorage.phoneNumberKEY),
      //avatarId: await AppStorage.storageRead(key:AppStorage.avatarKEY),
      token: await AppStorage.storageRead(key:AppStorage.tokenKEY),
      id: await AppStorage.storageRead(key:AppStorage.idKEY),
    );
   //print(user.name);
    Advance.theme =  await AppStorage.storageRead(key:AppStorage.themeKEY);
    Advance.language = await AppStorage.storageRead(key:AppStorage.languageKEY);
    Advance.isLogined =  await AppStorage.storageRead(key:AppStorage.isLoginedKEY);
    Advance.token =  await AppStorage.storageRead(key:AppStorage.tokenKEY);
    Advance.avatarImage =  await AppStorage.storageRead(key:AppStorage.avatarKEY);
  }

}