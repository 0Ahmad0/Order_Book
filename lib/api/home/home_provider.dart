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
  late List<RestaurantViews> listRatingRestaurant;
  bool recRatingRestaurant=false;
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
  Future<Map<String,dynamic>> ratingRestaurant(String token) async{
    //print( Uri.parse( AppUrl.login));
    //print( token);
    recRatingRestaurant=false;
    return await get(
        Uri.parse( AppUrl.ratingRestaurant)
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onValueRatingRestaurant).catchError(onError1);
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
int i=0;
      for(var element in responseData["data"]){
        print(i);
        print(element);

        i++;
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
    listOffers=[];
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
  Future<Map<String,dynamic>> onValueRatingRestaurant(http.Response response)async{
    var result;
    //listTrendingItems.clear();
   // listRatingRestaurant=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){
      listRatingRestaurant=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){
        RestaurantViews restaurantViews =RestaurantViews.fromJson(element);
        listRatingRestaurant.add(restaurantViews);
      }
      recRatingRestaurant=true;
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