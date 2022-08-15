import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/data/local/storage.dart';
import 'package:orderbook/domain/models.dart';
class AuthProvider extends ChangeNotifier{
  Future<FutureOr> register(String fName,String lName,String poneNumber,String avatarId,String deviceId) async{
    final Map<String,dynamic> bodyData={
      'name':fName+" "+lName,
      'phone_number':poneNumber,
      'device_id':deviceId,
      'avatar_id':avatarId,
    };
    return await post(
      Uri(path: AppUrl.register)
      ,headers: {
        "Accept":"application/json"
      },
      body: json.encode(bodyData),
    ).then(onValue).catchError(onError);
  }
  static onError(error){
    return{
      'status':false,
      'message':"Unsuccessful Request",
      'data':error
    };
  }
  static Future<FutureOr> onValue(http.Response response)async{
    var result;
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    if(response.statusCode==200){
      User userData = responseData['data'];
      User.fromJson(responseData);
      AppStorage.storageWrite(
        key: AppStorage.nameKEY,
        value: userData.name
      );
      AppStorage.storageWrite(
          key: AppStorage.phoneNumberKEY,
          value: userData.phoneNumber
      );
      AppStorage.storageWrite(
          key: AppStorage.avatarKEY,
          value: userData.avatarId
      );
      AppStorage.storageWrite(
          key: AppStorage.tokenKEY,
          value: userData.token
      );
      result ={
        'status':true,
        'message':"Successful Request",
        'data':responseData
      };

    }
  }

}