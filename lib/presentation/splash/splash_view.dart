import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orderbook/data/local/storage.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:orderbook/presentation/home/home_view.dart';
import 'package:orderbook/presentation/login/login_view.dart';
import 'package:orderbook/presentation/register/register_view.dart';
import '../animation/animation_page.dart';
import '../resources/theme_manager.dart';
import '../utils/sizer.dart';
import '/presentation/resources/assets_manager.dart';
import '/presentation/resources/color_manager.dart';
import '/presentation/resources/consts_manager.dart';
import '/presentation/resources/routes_manager.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
with SingleTickerProviderStateMixin{
  Timer? _timer;
  late AnimationController _controller;
  startDelay() {
    _controller.forward();
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async{
    // print("Advance==> ${Advance.isLogined}" );
    // Navigator.pushReplacementNamed(context, Routes.registerRoot);
     await AppStorage.storageRead(key: AppStorage.isLoginedKEY)
     ?
     Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) =>
        // BottomNavBarView()
       //HomeView()
     LoginView()


     ))
         :
     Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) =>
         LoginView()

     ));
     // Get.changeTheme(getApplicationTheme(isDark:Advance.theme ));

  }

  @override
  void initState() {
    AppStorage.init();
    _controller = AnimationController(
      duration: const Duration(seconds:  AppConstants.splashDelay),
      vsync: this,
    );
    super.initState();
    startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackF2,
      body: Center(
        child:  RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: ZoomIn(
            duration: Duration(milliseconds: 1500),
            child: SvgPicture.asset(
              ImagesAssets.splashLogo,
              width: Sizer.getW(context) * 0.35,
              height: Sizer.getW(context) * 0.35,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
