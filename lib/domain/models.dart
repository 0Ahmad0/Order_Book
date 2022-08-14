import 'package:firebase_auth/firebase_auth.dart';
//User
class User{
  String firstName;
  String lastName;
  String avatar;
  String phoneNumber;

  User(this.firstName,this.lastName,this.avatar,this.phoneNumber);
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
