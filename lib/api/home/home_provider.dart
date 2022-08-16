import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../domain/models.dart';
import '../app_url/app_url.dart';

class HomeProvider extends ChangeNotifier{
  User user = User();
  late List<Offers> listOffers ;
  late List<Restaurant> listRestaurants;
  late List<Item> listTrendingItems;
  Future<Map<String,dynamic>> trendingItems(String token) async{
//    print( Uri.parse( AppUrl.login));

  return await get(
      Uri.parse( AppUrl.trendingItems)
      ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
    "language":Advance.language?"en":"ar"
    }
    ).then(onValuetrendingItems).catchError(onError1);
  }
  Future<Map<String,dynamic>> trendingOffers(String token) async{
//    print( Uri.parse( AppUrl.login));

    return await get(
        Uri.parse( AppUrl.trendingOffers)
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onValuetrendingOffers).catchError(onError1);
  }

   onError1(error){
     print(error);
    return{
      'status':false,
      'message':"Unsuccessful Request",
      //  'data':error==null?"":error
    };
  }

   Future<Map<String,dynamic>> onValuetrendingItems(http.Response response)async{
    var result;

    //listTrendingItems.clear();
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){
      listTrendingItems=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){
        Item item =Item.fromJson(element);
        listTrendingItems.add(item);
      }
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
  Future<Map<String,dynamic>> onValuetrendingOffers(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){
      listOffers=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){
        Offers offer =Offers.fromJson(element);
        listOffers.add(offer);
      }
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