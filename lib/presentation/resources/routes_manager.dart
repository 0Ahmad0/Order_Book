import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../forget_password/forget_password_view.dart';
import '../login/login_view.dart';
import '/presentation/forget_password/forget_password_view.dart';
import '/presentation/login/login_view.dart';
import '/presentation/register/register_view.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/splash/splash_view.dart';
import '../splash/splash_view.dart';
import 'strings_manager.dart';

class Routes{
  static const String splashRoot = '/';
  static const String loginRoot = '/login';
  static const String registerRoot = '/register';
  static const String forgetPasswordRoot = '/forgetPassword';
  static const String onBoardingRoot = '/onBoarding';
  static const String mainRoot = '/main';
  static const String storeDetailsRoot = '/storeDetails';
}


class RoutesGenerator{
  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.splashRoot: 
      return MaterialPageRoute(builder: (_)=> SplashView());
       case Routes.loginRoot: 
      return MaterialPageRoute(builder: (_)=>const LoginView());
       case Routes.registerRoot: 
      return MaterialPageRoute(builder: (_)=>const RegisterView());
       case Routes.forgetPasswordRoot:
      return MaterialPageRoute(builder: (_)=>const ForgetPasswordView());
        default:
      return undefinedRoute();
    }
  }
  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(
        title:  Text(AppStrings.noRouteFound),
      ),
      body:  Center(child: Text(AppStrings.noRouteFound)),
    ));
  }
}