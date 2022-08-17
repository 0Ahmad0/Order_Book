import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List<Categories> listCategories= [];
  List<String> categories= [];
  List<int>idCategories= [];
  List<Reservations> listPendingReservations= [];
  List<Reservations> listRejectedReservations= [];
  List<Reservations> listAcceptedReservations= [];
  List<Reservations> listCancelledReservations= [];


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
  Future<Map<String,dynamic>> addReservations(String token,int table_id,int number_of_people,String date,String notes) async{
    print( Uri.parse( "${AppUrl.addReservations}"));
    print( date);
    print( token);
    print( Uri.parse( "${AppUrl.addReservations}"));
    print( date);
    print( token);
    List<Map> temp=[];

    //
    temp.add(
        {
          "table_id":16,
          "number_of_people":3,
          "date":"2022-08-26 16:00",
          "notes":"KKKKKKKKKK"
        });
    var request = http.MultipartRequest('POST', Uri.parse("${AppUrl.addReservations}"));
    request.headers.addAll({
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":"en",
    });
    request.fields['reservations'] = jsonEncode(temp);

    request.send();
    return {"G":"G"};
    /*List<Map> temp=[];
    temp.add(
    {
        "table_id":16,
        "number_of_people":3,
        "date":"2022-08-25 16:00",
        "notes":"KKKKKKKKKK"
        });
    Map<String, List<Map>> results = {
      "reservations": temp

    };

    final encodedResults = jsonEncode(results);
    return await post(
      Uri.parse( "${AppUrl.addReservations}"),
        headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":"en"
    },body: encodedResults
    ).then(onAddReservations).catchError(onError2);*/
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
  Future<Map<String,dynamic>> table(String token,int id) async{
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
  Future<Map<String,dynamic>> menuVendor(String token,int id) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.menuVendor}${id}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onMenuVendor).catchError(onError2);
  }
  Future<Map<String,dynamic>> pendingReservations(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myPendingReservations}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onMenuVendor).catchError(onError2);
  }
  Future<Map<String,dynamic>> rejectedReservations(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myRejectedReservations}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onRejectedReservations).catchError(onError2);
  }
  Future<Map<String,dynamic>> acceptedReservations(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.acceptedReservations}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onAcceptedReservations).catchError(onError2);
  }
  Future<Map<String,dynamic>> cancelledReservations(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myCancelledReservations}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onCancelledReservations).catchError(onError2);
  }
  Future<void> myReservations(String token) async{

  }


  static onError2(error){

    return{
      'status':false,
      'message':"Unsuccessful Request",
        'data':error==null?"":error
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
  static Future<Map<String,dynamic>> onAddReservations(http.Response response)async{
    var result;
    //print(response);
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
    categories=[];
    idCategories=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Tables table =Tables.fromJson(element);

        listTables.add(table);
        categories.add(table.name!);

        idCategories.add(table.id!);
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
  Future<Map<String,dynamic>> onMenuVendor(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listCategories=[];
    categories=[];
    idCategories=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Categories categorie =Categories.fromJson(element);

        listCategories.add(categorie);
        categories.add(categorie.name!);

       // idCategories.add(table.id!);
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
  Future<Map<String,dynamic>> onPendingReservations(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listPendingReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listPendingReservations.add(reservations);

        // idCategories.add(table.id!);
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
  Future<Map<String,dynamic>> onRejectedReservations(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listPendingReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listPendingReservations.add(reservations);

        // idCategories.add(table.id!);
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
  Future<Map<String,dynamic>> onAcceptedReservations(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listPendingReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listPendingReservations.add(reservations);

        // idCategories.add(table.id!);
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
  Future<Map<String,dynamic>> onCancelledReservations(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listPendingReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listPendingReservations.add(reservations);

        // idCategories.add(table.id!);
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