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
      rate: responseData['rate']!=null?responseData['rate'].toString().substring(0,3):"3",
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
  toJson(){
    return{
      "id":id,
      "notes":description,
      "quantity":"1",
    };
  }
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
      price:responseData["price"]!=null?0:responseData["price"],
      quantity:responseData["quantity"]!=null?responseData["quantity"]:"",
      //restaurant: responseData['restaurant']!={}?Restaurant.fromJson(responseData['restaurant']):Restaurant(address: "", imagesRestaurant: [], details: "", phoneNumber: "", name: "", imageLogo: ""),
    );
  }
  toJson(){
    return{
      "id":id,
      "notes":description,
      "quantity":quantity,
    };
  }
}
//table
class Table{
  String? left;
  String? top;
  int? id;
  String? table_image;
  int? max;
  int? min;
  String? qrCode;
  int? table_number;

  factory Table.fromJson(Map<String,dynamic> responseData){
    return Table(
      left: responseData['left'],
      top: responseData['top'],
      id:  responseData['id'],
      table_image:  responseData['table_image'],
      max:responseData["max"],
      min:responseData["min"],
      qrCode: responseData['qrCode'],
      table_number:responseData['table_number'],
    );
  }

  Table({this.left, this.top, this.id, this.table_image, this.max, this.min,
      this.qrCode,this.table_number});
}
//table
class Tables{
  String? name;
  String? image;
  int? id;
  List<Table>? tables=[];

  factory Tables.fromJson(Map<String,dynamic> responseData){
    List<Table> temp=[];

    for(var table in responseData['tables']){

      temp.add(Table.fromJson(table));
    }
    return Tables(
      name: responseData['name'],
      image: responseData['image'],
      id:  responseData['id'],
      tables:  temp ,
    );
  }

  Tables({this.name, this.image, this.id, this.tables});
}
//subCategories
class SubCategories{
  String? name;
  String? image;
  int? id;
  List<Item>? items=[];

  factory SubCategories.fromJson(Map<String,dynamic> responseData){
    List<Item> temp=[];

    for(var item in responseData['items']){

      temp.add(Item.fromJson(item));
    }
    return SubCategories(
      name: responseData['name'],
      image: responseData['image'],
      id:  responseData['id'],
      items:  temp ,
    );
  }

  SubCategories({this.name, this.image, this.id, this.items});
}
//subCategories
class Categories{
  int?  vendor;
  String? name;
  String? image;
  int? id;
  List<SubCategories>? subCategories=[];
  List<Item>? items=[];

  factory Categories.fromJson(Map<String,dynamic> responseData){
    List<SubCategories> temp=[];
    List<Item> temp1=[];

    for(var item in responseData['subCategories']){

      temp.add(SubCategories.fromJson(item));
    }
    for(var item in responseData['items']){

      temp1.add(Item.fromJson(item));
    }
    return Categories(
      name: responseData['name'],
      image: responseData['image'],
      id:  responseData['id'],
        vendor:responseData['vendor'],
      subCategories:  temp ,
      items: temp1

    );
  }

  Categories({this.name, this.image, this.id, this.subCategories,this.items,this.vendor});
}
//re
class Reservations{
  String? name;
  String? date;
  int? id;
  String? status;
  int? table_id;
  int? number_of_people;
  String? notes;

  factory Reservations.fromJson(Map<String,dynamic> responseData){

    return Reservations(
      name: responseData['vendor']['name'],
      date: responseData['date'],
      id:  responseData['id'],
      status:  responseData['status'],
      table_id:responseData["table_id"],
      number_of_people:responseData["number_of_people"],
      notes: responseData['notes'],
    );
  }

  Reservations({
    this.name,
  this.date,
  this.id,
  this.status,
  this.table_id,
  this.number_of_people,
  this.notes,});
}

//order
class Orders{
  String? name;
  List<Offers>? offers;
  List<Item>? item;
  int? id;
  String? status;
  int? table_id;
  int? vendor_id;
int? total_price;
  factory Orders.fromJson(Map<String,dynamic> responseData){
    List<Offers> temp=[];
    List<Item> temp1=[];

    for(var item in responseData['offers']["data"]){
      temp.add(Offers.fromJson(item));
    }

    for(var item in responseData['items']["data"]){

      temp1.add(Item.fromJson(item));
    }

    return Orders(
      name: responseData['vendor']['name'],
      vendor_id: responseData['vendor_id'],
      id:  responseData['id'],
      status:  responseData['status'],
      table_id:responseData["table_id"],
      total_price:responseData["total_price"],
      item: temp1,
      offers: temp,
    );
  }

  Orders({
    this.name,
    this.id,
    this.status,
    this.table_id,this.vendor_id,this.item,this.offers,this.total_price});
  toJson (){
    return {
    };
  }
}

class Cart{
  int? table_id;
  int? vendor_id;
  List<Offers>? offers;
  List<Item>? items;
  Cart({this.table_id, this.vendor_id, this.offers, this.items});
  factory Cart.fromJson(Map<String,dynamic> responseData){
    List<Offers> temp=[];
    List<Item> temp1=[];

    for(var item in responseData['offers']){
      temp.add(Offers.fromJson(item));
    }

    for(var item in responseData['items']){

      temp1.add(Item.fromJson(item));
    }
    return Cart(
      table_id: responseData["table_id"],
      vendor_id: responseData["vendor_id"],
      offers:  temp,
      items:  temp1,
    );
  }
  toJson(){
    List temp =[];
    for(Item item in items!){
      temp.add(item.toJson());
    }
    List temp1 =[];
    for(Offers elemet in offers!){
      temp1.add(elemet.toJson());
    }
    return {
        'table_id':table_id,
        'vendor_id':vendor_id,
        'offers':temp1,
        'items':temp,
    };
  }

}
//table
//StoryObject
class StoryObject{
  Offers? offers;
  int? numberOfStory;
  int? currentIndex;

  StoryObject({this.offers, this.numberOfStory, this.currentIndex});
}
