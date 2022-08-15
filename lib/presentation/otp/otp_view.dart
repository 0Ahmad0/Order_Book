import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:orderbook/presentation/home/home_view.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../api/auth/auth_provider.dart';
import '../resources/style_manager.dart';

class OTPView extends StatefulWidget {
  User user = User();
  OTPView(this.user);
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: AppSize.s14,),
            Text(
              AppStrings.verificationCode,
              style: getBoldStyle(
                color: ColorManager.lightPrimary,
                fontSize: Sizer.getW(context) * 0.045
              ),
            ),
            Image.asset(ImagesAssets.otpImage),
            Text(
              AppStrings.enterOTP,
              style: getMediumStyle(
                  color: ColorManager.redOTP,
                fontSize: Sizer.getW(context) * 0.04
              ),
            ),
            SizedBox(height: AppSize.s14,),
            Text(
              AppStrings.otpText,
              style: getRegularStyle(
                  color: ColorManager.lightPrimary,
                  fontSize: Sizer.getW(context) * 0.035
              ),
            ),
            SizedBox(height: AppSize.s18,),
            Expanded(child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(ImagesAssets.otpBackground)
                ),

              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  vertical: Sizer.getW(context) * 0.2,
                  horizontal: AppPadding.p24

                ),
                child: Column(
                  children: [
                    PinFieldAutoFill(
                  controller: otpController,
                  decoration: UnderlineDecoration(

                          textStyle: getRegularStyle(color: ColorManager.white,
                            fontSize: Sizer.getW(context) * 0.04
                          ),
                          colorBuilder: PinListenColorBuilder(
                              ColorManager.success,
                              ColorManager.white),
                        ),
                        autoFocus: true,
                        currentCode: "",

                        onCodeSubmitted: (val) {
                          print("Done");
                          Get.dialog(
                            Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: Sizer.getW(context) * 0.2,
                                height: Sizer.getW(context) * 0.2,
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: BorderRadius.circular(AppSize.s8)
                                ),
                                child: LoadingAnimationWidget.inkDrop(
                                    color: ColorManager.lightPrimary,
                                    size:Sizer.getW(context) * 0.1
                                )
                              ),
                            )
                          );
                          Timer(Duration(seconds: 4),(){
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (ctx)=>BottomNavBarView()));
                          });
                        },
                        onCodeChanged: (val) {

                        },
                        codeLength: 6),
                    const SizedBox(height: AppSize.s10,),
                    TextButton(onPressed: (){}, child: Text(
                        AppStrings.otpNotReceive,
                      style: getRegularStyle(color: ColorManager.white,
                      fontSize: Sizer.getW(context) * 0.033
                      ),
                    ))
                  ],
                ),
              ),

            ))
          ],
        ),
      ),
    );
  }
}

