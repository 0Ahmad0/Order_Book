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
  bool recRestaurant=false;
  List<RestaurantViews> listRestaurant= [];


  Future<Map<String,dynamic>> addFav(String token,int idVendor) async{
   print( Uri.parse( "${AppUrl.addFavourite}${idVendor}"));
   print( token);
    return await post(
      Uri.parse( "${AppUrl.addFavourite}${idVendor}")
      ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    },
    ).then(onValueAddFav).catchError(onError2);
  }

  static onError2(error){

    return{
      'status':false,
      'message':"Unsuccessful Request",
      //  'data':error==null?"":error
    };
  }
  static Future<Map<String,dynamic>> onValueAddFav(http.Response response)async{
    var result;
    // print(response);
    final Map<String,dynamic> responseData= json.decode(response.body);
    //print(responseData);
    print(responseData);
    print("status code ${await response.statusCode}");
    if(response.statusCode==201){
     // User userData = User.fromJson(responseData);
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