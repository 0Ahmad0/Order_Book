import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:orderbook/presentation/home/home_view.dart';
import 'package:orderbook/presentation/login/login_view.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/const.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../api/auth/auth_provider.dart';
import '../../translations/local_keys.g.dart';
import '../resources/style_manager.dart';
import '../utils/dataLocal.dart';

class OTPView extends StatefulWidget {
  User user = User();
  bool register=false;
  OTPView(this.user,this.register);
  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final otpController = TextEditingController();
  Future<void> register(AuthProvider authProvider) async {
    Const.LOADIG(context);
    //  var result =await authProvider.register("", "",widget.user.name, widget.user.phoneNumber, widget.user.avatarId, "ii");
    var result =await authProvider.register("", "",widget.user.name, widget.user.phoneNumber, widget.user.avatarId, "io5520");
    // var result =await authProvider.register("", "","temp", "+963970807997", 1, "igjui70iikii");
    print(result["message"]);
    Const.TOAST(context,textToast: result["message"]);

    Navigator.pop(context);
    if(result["status"]){
      Get.off(() =>LoginView());
      /// SnackBar(content: Text("k"));s

      //print("done register");
    }else{

      /// SnackBar(content: Text("o"));
      // print("field register");
    }
  }
  Future<void> login(AuthProvider authProvider,) async {
    Const.LOADIG(context);
    var result =await authProvider.Login( widget.user.phoneNumber);
    print(result);
    Const.TOAST(context,textToast: result["message"]);
    Navigator.pop(context);
    if(result["status"]){
      await DataLocal.getData();
      Navigator.pop(context);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (ctx)=>BottomNavBarView()));
      /// SnackBar(content: Text("k"));
      //print("done register");
      // Const.TOAST(context,textToast: result["message"]);
    }else{
      /// SnackBar(content: Text("o"));

    }
  }

  String codeValue = "";
  @override
  void initState(){
    super.initState();
    listenOtp();
  }
  void listenOtp()async{
    await SmsAutoFill().listenForCode();
  }
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
              tr(LocaleKeys.verificationCode),
              style: getBoldStyle(
                  color: ColorManager.lightPrimary,
                  fontSize: Sizer.getW(context) * 0.045
              ),
            ),
            Image.asset(ImagesAssets.otpImage),
            Text(
              tr(LocaleKeys.enterOTP),
              style: getMediumStyle(
                  color: ColorManager.redOTP,
                  fontSize: Sizer.getW(context) * 0.04
              ),
            ),
            SizedBox(height: AppSize.s14,),
            Text(
              tr(LocaleKeys.otpText),
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
                        currentCode: codeValue,
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
                        onCodeChanged: (val) async {
                          codeValue = val!;
                          setState((){});
                          if(val!=null&&val.length>5){
                            await (widget.register)?register(authProvider):login(authProvider);


                            /*  Timer(Duration(seconds: 3), (){
                        Navigator.pop(context);

                      });*/


                          }
                        },
                        codeLength: 6,
                    ),
                    const SizedBox(height: AppSize.s10,),
                    TextButton(onPressed: (){}, child: Text(
                      tr(LocaleKeys.otpNotReceive),
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


