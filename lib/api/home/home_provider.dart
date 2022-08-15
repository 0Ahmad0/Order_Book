import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../domain/models.dart';
import '../app_url/app_url.dart';

class HomeProvider extends ChangeNotifier{
  User user = User();
  void getUser(){

  }
  /*
  Future<Map<String,dynamic>> register(String fName,String lName,String name,String phoneNumber,int avatarId,String deviceId) async{
    /*final Map<String,dynamic> bodyData={
      'name':name,
      'phone_number':phoneNumber,
      'device_id':deviceId,
      'avatar_id':avatarId.toString(),
    };*/
    // print( Uri.parse( AppUrl.register));
    return await post(
      Uri.parse( AppUrl.register)
      ,headers: {
      "Accept":"application/json"
    },
      body: {
        'name':name,
        'phone_number':phoneNumber,
        'device_id':deviceId,
        'avatar_id':avatarId.toString(),
      },
    ).then(onValueReg).catchError(onError);
  }
  Future<Map<String,dynamic>> Login(String phoneNumber) async{
//    print( Uri.parse( AppUrl.login));
    return await post(
      Uri.parse( AppUrl.login)
      ,headers: {
      "Accept":"application/json"
    },
      body: {
        'phone_number':phoneNumber,
      },
    ).then(onValueLog).catchError(onError);
  }
  static onError(error){
    return{
      'status':false,
      'message':"Unsuccessful Request",
      //  'data':error==null?"":error
    };
  }
  static Future<Map<String,dynamic>> onValueReg(http.Response response)async{
    var result;
    final Map<String,dynamic> responseData= json.decode(response.body);
    //print(responseData);
    // print("status code $response.statusCode");
    if(response.statusCode==201){
      User userData = User.fromJson(responseData);
      /*
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
      */
      result ={
        'status':true,
        'message':"Successful Request",
        'data':responseData
      };
    }
    else {
      result ={
        'status':false,
        'message':responseData["message"],
        'data':responseData
      };
    }
    return result;
  }
  static Future<Map<String,dynamic>> onValueLog(http.Response response)async{
    var result;
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){
      User userData = User.fromJson(responseData);
      AppStorage.init();
      AppStorage.storageWrite(
          key: AppStorage.nameKEY,
          value: userData.name
      );
      AppStorage.storageWrite(
          key: AppStorage.phoneNumberKEY,
          value: userData.phoneNumber
      );
      AppStorage.storageWrite(
          key: AppStorage.isLoginedKEY,
          value: true
      );
      /* AppStorage.storageWrite(
          key: AppStorage.avatarKEY,
          value: userData.avatarId
      );*/
      AppStorage.storageWrite(
          key: AppStorage.tokenKEY,
          value: userData.token
      );
      result ={
        'status':true,
        'message':"Successful Request",
        'data':responseData
      };
    }else {
      result ={
        'status':false,
        'message':responseData["message"],
        'data':responseData
      };
    }
    return result;
  }*/

}