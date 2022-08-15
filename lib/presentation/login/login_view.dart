import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:orderbook/api/auth/auth_provider.dart';
import 'package:orderbook/presentation/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:orderbook/presentation/home/home_view.dart';
import 'package:orderbook/presentation/login/login_view_model.dart';
import 'package:orderbook/presentation/register/register_view.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../data/local/storage.dart';
import '../../domain/models.dart';
import '../otp/otp_view.dart';
import '../resources/routes_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';
import '../utils/const.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel = LoginViewModel();
  final TextEditingController phoneNumber = TextEditingController();
  bool type = false;
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // loginViewModel.start();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          buildTopContainerLoginView(context),
          Expanded(
            child: FadeInRightBig(
              duration: Duration(milliseconds: 1800),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p20, vertical: AppPadding.p8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFiled(
                        controller: phoneNumber,
                          textInputType: TextInputType.phone,
                          textInputAction:TextInputAction.done,
                          maxLength: 10,
                          validator:(val) {
                            if(val!.trim().isEmpty){
                              return AppStrings.fieldNotEmpty;
                            }
                            if(!val.toString().isPhoneNumber || val.length!=10){
                              return AppStrings.validPhone;
                            }
                            if(!val.startsWith("09")){
                              return AppStrings.phoneStart09;
                            }
                            return null;
                          },
                        onChange: (val) {
                          if (val.trim().isNotEmpty) {
                            type = true;
                            setState(() {});
                          } else {
                            type = false;
                            setState(() {});
                          }
                        },
                          prefixIcon: Icons.phone,
                          hintText: AppStrings.hintPhone,
                          validFiled: type,

                      ),
                      const SizedBox(
                        height: AppSize.s20,
                      ),
                      ButtonApp(
                        text: AppStrings.loginText,
                        fontSize: Sizer.getW(context) * 0.05,
                        onTap: () async {
                          Const.TOAST(context,textToast: "Hello");
                          if (_formKey.currentState!.validate()) {
                            Const.LOADIG(context);
                            var result =await authProvider.checkNumber( phoneNumber.text.replaceFirst("0","+963" ));
                            Navigator.pop(context);
                            if(result["status"]){
                              Navigator.push(context,
                                  MaterialPageRoute(builder:
                                      (ctx)=>OTPView(
                                      User(
                                          phoneNumber: phoneNumber.text.replaceFirst("0","+963" )
                                      ),
                                      false
                                  ))
                              );
                            }

                          }


                          /*if (_formKey.currentState!.validate()) {
                            AppStorage.init();
                            AppStorage.storageWrite(
                                key: AppStorage.isLoginedKEY,
                                value: true
                            );
                            Get.defaultDialog(
                                backgroundColor: ColorManager.white4,
                                title: "Successful Logined",
                                titleStyle: getRegularStyle(
                                    color: ColorManager.black,
                                    fontSize: Sizer.getW(context) * 0.04),
                                content: Icon(
                                  Icons.check_circle,
                                  size: AppSize.s60,
                                  color: ColorManager.success,
                                ),
                                radius: 4.0);
                           /* Timer(Duration(seconds: 3), () async{
                              Navigator.pop(context);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (ctx)=>BottomNavBarView()));
                            });*/
                          }*/
                        },
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dontHaveAccount,
                            style: getRegularStyle(color: ColorManager.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => RegisterView()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(AppPadding.p8),
                              child: Text(
                                AppStrings.signupText,
                                style: getLightStyle(
                                    color: ColorManager.lightSecondary,
                                    fontSize: Sizer.getW(context) * 0.038),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget buildTopContainerLoginView(BuildContext context) {
    return Expanded(
      child: FadeInDownBig(
        duration: Duration(milliseconds: 1000),
        child: ClipPath(
          clipper: Customshape(),
          child: Container(
            alignment: Alignment.center,
            width: Sizer.getW(context),
            // height: Sizer.getH(context) / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        ColorManager.black.withOpacity(.75), BlendMode.darken),
                    image: AssetImage(ImagesAssets.loginBackground))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.appName,
                  style: getBoldStyle(
                      fontSize: Sizer.getW(context) * 0.08,
                      color: ColorManager.white),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Text(
                    AppStrings.loginWelcomeText,
                    textAlign: TextAlign.center,
                    style: getLightStyle(
                        fontSize: Sizer.getW(context) * 0.04,
                        color: ColorManager.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonApp extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color colorButton;
  final Color colorButtonText;
  final double fontSize;

  ButtonApp(
      {super.key,
      required this.text,
      required this.onTap,
      this.colorButton = ColorManager.lightPrimary,
      this.colorButtonText = ColorManager.white,
      this.fontSize = 16.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: getSemiBoldStyle(
            color: colorButtonText,
            fontSize: fontSize,
          ),
        ));
  }
}

class Customshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - AppSize.s50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class CustomTextFiled extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final int? maxLength;
  var validator;
  var onChange;
  final IconData prefixIcon;
  final String hintText;
  bool validFiled;


   CustomTextFiled(
      {super.key,
      required this.controller,
       this.textInputType = TextInputType.text,
       this.textInputAction = TextInputAction.next,
       this.autoFocus = false,
       this.maxLength = 0,
      required this.validator,
      required this.onChange,
      required this.prefixIcon,
      required this.hintText,
        this.validFiled = false
      });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.textInputType,
      maxLength: widget.maxLength,
      textInputAction: widget.textInputAction,
      autofocus: widget.autoFocus,
      validator: widget.validator,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.prefixIcon),
        suffixIcon: widget.validFiled
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  widget.controller.clear();
                  widget.validFiled = false;
                  setState(() {});
                },
              )
            : null,
        hintText: widget.hintText,
      ),
    );
  }
}
