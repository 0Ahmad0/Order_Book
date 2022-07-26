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

import 'dart:convert';

JobCreateRequestModel jobCreateRequestModelFromJson(String str) => JobCreateRequestModel.fromJson(json.decode(str));

String jobCreateRequestModelToJson(JobCreateRequestModel data) => json.encode(data.toJson());

class JobCreateRequestModel {
  JobCreateRequestModel({
    required this.reservations1,
  });

  List<Reservations1> reservations1;

  factory JobCreateRequestModel.fromJson(Map<String, dynamic> json) => JobCreateRequestModel(
    reservations1: List<Reservations1>.from(json["reservations"].map((x) => Reservations1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "reservations": List<dynamic>.from(reservations1.map((x) => x.toJson())),
  };
}

class Reservations1 {
  Reservations1({
    required this.table_id,
     required this.notes,
    required this.date,
    required this.number_of_people
  });

  int table_id;
  int number_of_people;
  String date;
  String notes;

  factory Reservations1.fromJson(Map<String, dynamic> json) => Reservations1(
    table_id: json["table_id"],
    number_of_people: json["number_of_people"],
    date: json["date"],
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "table_id": table_id,
    "number_of_people": number_of_people,
    "date": date,
    "notes": notes,
  };
}



class CarJson {
  int table_id;
  int number_of_people;
  String notes;
  String date;
  CarJson({required this.table_id, required this.date, required this.number_of_people, required this.notes});
  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["table_id"] = table_id;
    map["notes"] = notes;
    map["number_of_people"] = number_of_people;
    map["date"] = date;
    return map;
  }
}
class RestaurantsProvider extends ChangeNotifier{
  bool recRestaurant=false;
  List<RestaurantViews> listRestaurant= [];
  List<Tables> listTables= [];
  List<Categories> listCategories= [];
  int id_vendor=0;
  List<String> categories= [];
  List<int>idCategories= [];
  List<Reservations> listPendingReservations= [];
  List<Reservations> listRejectedReservations= [];
  List<Reservations> listAcceptedReservations= [];
  List<Reservations> listCancelledReservations= [];

  List<Orders> listPendingOrders= [];
  List<Orders> listRejectedOrders= [];
  List<Orders> listServedOrders= [];
  List<Orders> listCancelledOrders= [];
  List<Orders> listMyAcceptedOrders= [];

  Cart? cart;
  static Cart? carts;
  Item? item;


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
    var request = http.MultipartRequest('POST', Uri.parse("${AppUrl.addReservations}"));
    request.headers.addAll({
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":"en",
    });

    return await http.post(
        Uri.parse( "${AppUrl.addReservations}"),
        headers: {"Accept":"application/json",
          "Authorization": "Bearer $token",
          "language":"en",},
          body: {
              "table_id":table_id.toString(),
              "number_of_people":number_of_people.toString(),
              "date":"2022-08-27 18:00",
              "notes":notes
          }).then(onAddReservations).catchError(onError2);



  }
  Future<Map<String,dynamic>> addOrder(String token) async{
    print( Uri.parse( "${AppUrl.addOrder}"));
    /*var request = http.MultipartRequest('POST', Uri.parse("${AppUrl.addReservations}"));
    request.headers.addAll({
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":"en",
    });*/
   // Item item=Item(id: 1,quantity: "7",description: "ffff");
    var mapTemp=Map<String,dynamic>();
    mapTemp['id']="1";
    mapTemp['notes']="7";
    mapTemp['quantity']="sdf";
    var mapListTemp=Map<String,dynamic>();
    mapListTemp['temps']=[mapTemp];
    print(mapListTemp);
    var mapOffer=Map<String,dynamic>();
    mapOffer['id']=1;
    mapOffer['notes']=7;
    mapOffer['quantity']="sdf";
    var mapListOffer=Map<String,dynamic>();
    mapListOffer['offers']=[];
    print(mapListOffer);
    var map=Map<String,dynamic>();
    int id1=1;
    int id2=2;
    map['table_id']=1;
    map['vendor_id']=2;
    map['items']=[mapTemp];
    map['offers']=[mapOffer];
    print(jsonDecode(jsonEncode(map))['items']);

    /*List<Item> items=[];
    items.add(item);
    Offers offer=Offers(id: 1,description: "ffff");
    List<Offers> offers=[];
    offers.add(offer);
    Cart cart=Cart(table_id: 10,vendor_id: 1,offers: offers,items: items);
    print(cart.toJson());*/
    return await http.post(
        Uri.parse( "${AppUrl.addOrder}"),
        headers: {"Accept":"application/json",
          "Authorization": "Bearer $token",
          "language":"en",},
        body: {
          'table_id':"1",
          'vendor_id':"2",
          'items':jsonEncode(map['items']),
          'offers':jsonEncode(mapListOffer),
        }//cart.toJson()
    ).then(onAddorder).catchError(onError2);
  }
  static Future<Map<String,dynamic>> onAddorder(http.Response response)async{
    var result;
    //print(response);
    print(response);
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
  Future<Map<String,dynamic>> menuQr(String token,int id_table) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;

    return await get(
        Uri.parse( "${AppUrl.menuQr}${id_table}")
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
    ).then(onPendingReservations).catchError(onError2);
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
  Future<Map<String,dynamic>> myReservations(String token) async{
    var res;
    res= await pendingReservations(token);
    res=await rejectedReservations(token);
    res=await acceptedReservations(token);
    res=await cancelledReservations(token);
    return res;
  }
  Future<Map<String,dynamic>> cancelledReservation(String token,int idReservation) async{
    print( Uri.parse( "${AppUrl.cancelledReservation}${idReservation}"));
    print( token);
    return await put(
      Uri.parse( "${AppUrl.cancelledReservation}${idReservation}")
      ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    },
    ).then(onCancelledReservation).catchError(onError2);
  }

  Future<Map<String,dynamic>> myPendingOrders(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myPendingOrders}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onPendingOrders).catchError(onError2);
  }
  Future<Map<String,dynamic>> myRejectedOrders(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myRejectedOrders}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onRejectedOrders).catchError(onError2);
  }
  Future<Map<String,dynamic>> myServedOrders(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myServedOrders}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onServedOrders).catchError(onError2);
  }
  Future<Map<String,dynamic>> myCancelledOrders(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myCancelledOrders}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onCancelledOrders).catchError(onError2);
  }
  Future<Map<String,dynamic>> myAcceptedOrders(String token) async{
//    print( Uri.parse( AppUrl.login));
    recRestaurant=false;
    return await get(
        Uri.parse( "${AppUrl.myAcceptedOrders}")
        ,headers: {
      "Accept":"application/json",
      "Authorization": "Bearer $token",
      "language":Advance.language?"en":"ar"
    }
    ).then(onMyAcceptedOrders).catchError(onError2);
  }
int getPrice(int index){
    return listPendingOrders[index].id!*250;
}
  Future<Map<String,dynamic>> myOrders(String token) async{
    var res;
    res= await myPendingOrders(token);
    res=await myRejectedOrders(token);
    res=await myServedOrders(token);
    res=await myCancelledOrders(token);
    res=await myAcceptedOrders(token);
    return res;
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
      responseData["data"]["vendor"]!=null?id_vendor=responseData["data"]["vendor"]:"";
      for(var element in responseData["data"]["categories"]){
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
    print(await response);
    print("await response");
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
    listRejectedReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listRejectedReservations.add(reservations);

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
    listAcceptedReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listAcceptedReservations.add(reservations);

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
    listCancelledReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listCancelledReservations.add(reservations);

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
  Future<Map<String,dynamic>> onMyAcceptedOrders(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listAcceptedReservations=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Reservations reservations =Reservations.fromJson(element);

        listAcceptedReservations.add(reservations);

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

  Future<Map<String,dynamic>> onCancelledOrders(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listCancelledOrders=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Orders orders =Orders.fromJson(element);

        listCancelledOrders.add(orders);

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
  Future<Map<String,dynamic>> onPendingOrders(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listPendingOrders=[];
    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Orders orders =Orders.fromJson(element);

        listPendingOrders.add(orders);

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
  Future<Map<String,dynamic>> onRejectedOrders(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listRejectedOrders=[];

    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");
    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Orders orders =Orders.fromJson(element);

        listRejectedOrders.add(orders);
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
  Future<Map<String,dynamic>> onServedOrders(http.Response response)async{
    var result;
    //listTrendingItems.clear();
    listServedOrders=[];

    final Map<String,dynamic> responseData= json.decode(response.body);
    print(responseData);
    print("status code ${response.statusCode}");

    if(response.statusCode==200){

      //listTables=[];
      //listTrendingItems.clear();
      for(var element in responseData["data"]){

        Orders orders =Orders.fromJson(element);

        listServedOrders.add(orders);

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
   Future<Map<String,dynamic>> onCancelledReservation(http.Response response)async{
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

}