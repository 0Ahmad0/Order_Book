//Function To Get Text Style 

import 'package:flutter/cupertino.dart';
import '/presentation/resources/font_manager.dart';

TextStyle _getTetxStyle({double? fontSize, FontWeight? fontWeight , Color? color}){
return TextStyle(fontFamily: FontConstance.fontFamily , fontSize: fontSize,fontWeight: fontWeight , color: color);
}

///Regular Style 
TextStyle getRegularStyle({double? fontSize = FontSize.s12,required Color? color}){
  return _getTetxStyle(
    fontSize: fontSize,
    fontWeight: FontWegihtManager.regular,
    color: color
  );
}

///Bold Style 
TextStyle getBoldStyle({double? fontSize = FontSize.s12,required Color? color}){
  return _getTetxStyle(
    fontSize: fontSize,
    fontWeight: FontWegihtManager.bold,
    color: color
  );
}

///SemiBold Style 
TextStyle getSemiBoldStyle({double? fontSize = FontSize.s12,required Color? color}){
  return _getTetxStyle(
    fontSize: fontSize,
    fontWeight: FontWegihtManager.semiBold,
    color: color
  );
}

///Bold Style 
TextStyle getMediumStyle({double? fontSize = FontSize.s12,required Color? color}){
  return _getTetxStyle(
    fontSize: fontSize,
    fontWeight: FontWegihtManager.medium,
    color: color
  );
}

///Light Style 
TextStyle getLightStyle({double? fontSize = FontSize.s12,required Color? color}){
  return _getTetxStyle(
    fontSize: fontSize,
    fontWeight: FontWegihtManager.light,
    color: color
  );
}