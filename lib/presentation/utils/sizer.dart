import 'package:flutter/material.dart';

class Sizer{
  static double getW(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getH(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
}