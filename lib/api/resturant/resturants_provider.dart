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
  List<Tables> listTables= [];


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
    ).then(onAddValueFav).catchError(onError2);
  }
  Future<Map<String,dynamic>> deleteFav(String token,int idVendor) async{
    print( Uri.parse( "${AppUrl.deleteFavourite}${idVendor}"));
    print( token);
    return await delete(
      Uri.parse( "${AppUrl.deleteFavourite}${idVendor}")
      ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    },
    ).then(onDeleteValueFav).catchError(onError2);
  }
  Future<Map<String,dynamic>> trendingOffers(String token,String id) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.tables}${id}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onValueTable).catchError(onError2);
  }

  static onError2(error){

    return{
      'status':false,
      'message':"Unsuccessful Request",
      //  'data':error==null?"":error
    };
  }
  static Future<Map<String,dynamic>> onAddValueFav(http.Response response)async{
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
  static Future<Map<String,dynamic>> onDeleteValueFav(http.Response response)async{
    var result;
    // print(response);
    final Map<String,dynamic> responseData= json.decode(response.body);
    //print(responseData);
    print(responseData);
    print("status code ${await response.statusCode}");
    if(response.statusCode==200){
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
  Future<Map<String,dynamic>> onValueTable(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listTables=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){
      listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){
        Tables table =Tables.fromJson(element);
        listTables.add(table);
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

}