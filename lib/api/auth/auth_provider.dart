import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/api/resturant/resturants_provider.dart';
import 'package:orderbook/data/local/storage.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/utils/dataLocal.dart';

import '../home/home_provider.dart';
class AuthProvider extends  HomeProvider{
  Future<Map<String,dynamic>> register(String fName,String lName,String name,String phoneNumber,int avatarId,String deviceId) async{
   //print( Uri.parse( AppUrl.register));
    return await post(
      Uri.parse( AppUrl.register)
      ,headers: {
        "Accept":"application/json"
      },
      body: {
        'name':name,
        'phone_number':phoneNumber,
        'device_id':deviceId,
        'avatar_id':"1",//avatarId.toString(),
      },
    ).then(onValueReg).catchError(onError);
  }
  Future<Map<String,dynamic>> checkNumber(String phoneNumber) async{
//    print( Uri.parse( AppUrl.login));
    return await post(
      Uri.parse( AppUrl.checkNumber)
      ,headers: {
      "Accept":"application/json"
    },
      body: {
        'phone_number':phoneNumber,
      },
    ).then(onValueCheckNum).catchError(onError);
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

  Future<Map<String,dynamic>> Logout(String token) async{
//    print( Uri.parse( AppUrl.login));
  //  print(token);
    return await delete(
      Uri.parse( AppUrl.logout)
      ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token"
      //'token': '$token',
    },
    ).then(onValueOut).catchError(onError);
  }
  Future<Map<String,dynamic>> updateProfile(String token,String name,int avatar_id) async{

    return await put(
      Uri.parse( AppUrl.updateProfile)
      ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token"
    },
      body: {
        'name':name,
      },
    ).then(onValueUpdate).catchError(onError);
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
   // print(response);
    final Map<String,dynamic> responseData= json.decode(response.body);
    //print(responseData);
    print(responseData);
   // print("status code $response.statusCode");
    if(response.statusCode==201){
      User userData = User.fromJson(responseData);
      await AppStorage.init();
      Advance.token=userData.token;
      await AppStorage.storageWrite(
          key: AppStorage.tokenKEY,
          value: userData.token
      );
      result ={
        'status':true,
        'message':"Successful Request",
        'data':responseData
      };
      print(responseData);
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
      await AppStorage.init();
      await AppStorage.storageWrite(
          key: AppStorage.nameKEY,
          value: userData.name
      );
      await AppStorage.storageWrite(
          key: AppStorage.phoneNumberKEY,
          value: userData.phoneNumber
      );
      await   AppStorage.storageWrite(
          key: AppStorage.isLoginedKEY,
          value: true
      );
     /* AppStorage.storageWrite(
          key: AppStorage.avatarKEY,
          value: userData.avatarId
      );*/
      await AppStorage.storageWrite(
          key: AppStorage.tokenKEY,
          value: userData.token
      );
      await AppStorage.storageWrite(
          key: AppStorage.idKEY,
          value: userData.id
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
    }
  static Future<Map<String,dynamic>> onValueOut(http.Response response)async{
    var result;
     Map<String,dynamic> responseData= {};
    if(!response.body.isEmpty){
      responseData = json.decode(response.body);
      print(await responseData);
    }
    print("status code ${await response.statusCode}");
    if(response.statusCode==200){
      //User userData = User.fromJson(responseData);
      AppStorage.depose();
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
  }
  static Future<Map<String,dynamic>> onValueUpdate(http.Response response)async{
    var result;
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){

      User userData = User.fromJson(responseData);
      await AppStorage.storageWrite(
          key: AppStorage.nameKEY,
          value: userData.name
      );

      DataLocal.user.name =userData.name;
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
  }
  static Future<Map<String,dynamic>> onValueCheckNum(http.Response response)async{
    var result;
    print(result);
    Map<String,dynamic> responseData= {};
    if(!response.body.isEmpty){
      responseData = json.decode(response.body);
      print(await responseData);
    }
    print("status code ${ response.statusCode}");
    if(response.statusCode==200){
      //User userData = User.fromJson(responseData);
      AppStorage.depose();
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
  }
}