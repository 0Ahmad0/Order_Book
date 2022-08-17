import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//User
class User{
  //String firstName;
 // String lastName;
  String name;
  int avatarId;
  String phoneNumber;
  int id;
 String token ;
  User({this.name="", this.avatarId=0, this.phoneNumber="", this.id=0, this.token=""});
  factory User.fromJson(Map<String,dynamic> responseData){
    return User(
      id: responseData["data"]['id'],
      name: responseData["data"]['name'],
        phoneNumber:  responseData["data"]['phone_number'],
        avatarId:  responseData["data"]['avatar_id'],
      token: responseData["meta"]!=null?responseData["meta"]['access_token']:Advance.token,
    );
  }
  toJson(){
    return {
      "data": {
        'id':this.id,
        'name':name,
        'phone_number':phoneNumber,
        'avatar_id':avatarId,
      },
      "meta":{
        'access_token':token
      }
    };
  }
}

//Advance
class Advance{
  static bool theme = false;
  static bool language = false;
  static bool isRegisterKEY = false;
  static bool isLogined = false;
  static String token = "";
  static String avatarImage = "";
}

//Restaurant
class Restaurant{
  String? imageLogo;
  String? name;
  String? address;
  String? details;
  String? phoneNumber;
  bool? isFavorite;
  String? rate;
  int? id;
  List<dynamic>? imagesRestaurant;

  Restaurant(
      {
        this.id,
      required this.imageLogo,
      required this.name,
      required this.address,
      required this.details,
      required this.phoneNumber,
       this.isFavorite = false,
       this.rate = "1",
      required this.imagesRestaurant
      });
  factory Restaurant.fromJson(Map<String,dynamic> responseData){
    return Restaurant(
      id: responseData['id'],
      imageLogo: responseData['imageLogo'],
      name: responseData['name'],
      address:  responseData['address'],
      details:  responseData['details'],
      phoneNumber:responseData["phoneNumber"],
      isFavorite:responseData["isFavorite"],
      rate: responseData['rate'],
        imagesRestaurant:responseData["imagesRestaurant"],
    );
  }
}
class RestaurantViews{
  String? imageLogo;
  String? name;
  int? id;
  String? longitude;
  String? latitude;
  bool? isFavorite;
  String? rate;
  List<dynamic>? images=[];

  RestaurantViews(
      {
         this.imageLogo,
         this.name,
         this.longitude,
         this.latitude,
         this.id,
        this.isFavorite = false,
        this.rate = "3",
        this.images,
      });
  factory RestaurantViews.fromJson(Map<String,dynamic> responseData){
    return RestaurantViews(
      imageLogo: responseData['logo'],
      name: responseData['name'],
      longitude:  responseData['longitude'],
      latitude:  responseData['latitude'],
      id:responseData["id"],
      isFavorite:responseData["favourite"]!=null?responseData["favourite"]:false,
      rate: responseData['rate']!=null?responseData['rate'].toString().substring(0,2):"3",
      images: responseData['images'],
    );
  }
}
//Offers
class Offers{
  int? id;
  String? name;
  String? description;
  int? price;
  String? image;
  String? from_date;
  RestaurantViews? restaurantViews;
  String? to_date;

  factory Offers.fromJson(Map<String,dynamic> responseData){
    return Offers(
      id: responseData['id'],
      name:responseData['name'],
      image:responseData['image'],
      description:responseData['description'],
      price:responseData['price'],
      restaurantViews:RestaurantViews.fromJson(responseData['vendor']),
      to_date:responseData['to_date'],
      from_date:responseData['from_date'],

   //   restaurant: responseData['restaurant']!={}?Restaurant.fromJson(responseData['restaurant']):Restaurant(address: "", imagesRestaurant: [], details: "", phoneNumber: "", name: "", imageLogo: ""),
    );
  }

  Offers(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.image,
      this.from_date,
      this.restaurantViews,
      this.to_date});
}
//item
class Item{
  int? id;
  String? name;
  String? description;
  String? image;
  int? price;
  String? quantity;
  Restaurant? restaurant=Restaurant(address: "", imagesRestaurant: [], details: "", phoneNumber: "", name: "", imageLogo: "");
  Item(
      {this.id=1,
      this.name="name",
      this.description="description",
      this.image="",
      this.price= 0,
      this.quantity="",
      this.restaurant});
  factory Item.fromJson(Map<String,dynamic> responseData){
    return Item(
      id: responseData['id'],
      name: responseData['name'],
      description:  responseData['description'],
      image:  responseData['image'],
      price:responseData["price"],
      quantity:responseData["quantity"],
      //restaurant: responseData['restaurant']!={}?Restaurant.fromJson(responseData['restaurant']):Restaurant(address: "", imagesRestaurant: [], details: "", phoneNumber: "", name: "", imageLogo: ""),
    );
  }
}
//table
class Table{
  String? left;
  String? top;
  int? id;
  String? table_image;
  String? max;
  bool? min;
  String? qrCode;

  factory Table.fromJson(Map<String,dynamic> responseData){
    return Table(
      left: responseData['left'],
      top: responseData['top'],
      id:  responseData['id'],
      table_image:  responseData['table_image'],
      max:responseData["max"],
      min:responseData["min"],
      qrCode: responseData['qrCode'],
    );
  }

  Table({this.left, this.top, this.id, this.table_image, this.max, this.min,
      this.qrCode});
}
//table
class Tables{
  String? name;
  String? image;
  int? id;
  List<dynamic>? tables=[];

  factory Tables.fromJson(Map<String,dynamic> responseData){
    return Tables(
      name: responseData['name'],
      image: responseData['image'],
      id:  responseData['id'],
      tables:  responseData['tables'],
    );
  }

  Tables({this.name, this.image, this.id, this.tables});
}
//StoryObject
class StoryObject{
  Offers? offers;
  int? numberOfStory;
  int? currentIndex;

  StoryObject({this.offers, this.numberOfStory, this.currentIndex});
}
