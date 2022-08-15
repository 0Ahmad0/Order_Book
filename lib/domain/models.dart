import 'package:firebase_auth/firebase_auth.dart';
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
  int? rate;
  List<String>? imagesRestaurant;

  Restaurant(
      {
      required this.imageLogo,
      required this.name,
      required this.address,
      required this.details,
      required this.phoneNumber,
       this.isFavorite = false,
       this.rate = 1,
      required this.imagesRestaurant
      });
}
//Offers
class Offers{
  String? image;
  Restaurant? restaurant;
  String? text;
  Offers({this.image,this.restaurant,this.text});
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
}
//StoryObject
class StoryObject{
  Offers? offers;
  int? numberOfStory;
  int? currentIndex;

  StoryObject({this.offers, this.numberOfStory, this.currentIndex});
}
