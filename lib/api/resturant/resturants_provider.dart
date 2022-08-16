import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/data/local/storage.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/utils/dataLocal.dart';
class RestaurantsProvider extends ChangeNotifier{

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

}