import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/parser.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:orderbook/api/auth/auth_provider.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/otp/otp_view.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:orderbook/presentation/utils/user_storage_data.dart';
import 'package:provider/provider.dart';
import '../login/login_view.dart';
import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

var isDark = false.obs;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map checkValidate = {
    "firstName": false,
    "lastName": false,
    "phoneNumber": false,
  };

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: ColorManager.lightPrimary,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTopContainerRegisterView(context),
                Expanded(
                    child: FadeInUpBig(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p40,
                        horizontal: AppPadding.p20,
                      ),
                      decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppSize.s40))),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            CustomTextFiled(
                              controller: firstName,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              maxLength: null,
                              validator: (val) {
                                if (val!.trim().isEmpty) {
                                  return AppStrings.fieldNotEmpty;
                                }
                                //TODO start with number and [~!@#$%^&*]
                                // if(!val.toString().isPhoneNumber){
                                //   return AppStrings.phoneStart09;
                                // }
                                return null;
                              },
                              onChange: (val) {
                                if (val.trim().isNotEmpty) {
                                  checkValidate["firstName"] = true;
                                  setState(() {});
                                } else {
                                  checkValidate["firstName"] = false;
                                  setState(() {});
                                }
                              },
                              prefixIcon: Icons.person,
                              hintText: AppStrings.firstName,
                              validFiled: checkValidate["firstName"],
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            CustomTextFiled(
                              controller: lastName,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              autoFocus: false,
                              maxLength: null,
                              validator: (val) {
                                if (val!.trim().isEmpty) {
                                  return AppStrings.fieldNotEmpty;
                                }
                                //TODO start with number and [~!@#$%^&*]
                                // if(!val.toString().isPhoneNumber){
                                //   return AppStrings.phoneStart09;
                                // }
                                return null;
                              },
                              onChange: (val) {
                                if (val.trim().isNotEmpty) {
                                  checkValidate["lastName"] = true;
                                  setState(() {});
                                } else {
                                  checkValidate["lastName"] = false;
                                  setState(() {});
                                }
                              },
                              prefixIcon: Icons.person,
                              hintText: AppStrings.lastName,
                              validFiled: checkValidate["lastName"],
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            CustomTextFiled(
                              controller: phoneNumber,
                              textInputType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              autoFocus: false,
                              maxLength: 10,
                              validator: (val) {
                                if (val!.trim().isEmpty) {
                                  return AppStrings.fieldNotEmpty;
                                }
                                if (!val.toString().isPhoneNumber ||
                                    val.length != 10) {
                                  return AppStrings.validPhone;
                                }
                                if (!val.startsWith("09")) {
                                  return AppStrings.phoneStart09;
                                }
                                return null;
                              },
                              onChange: (val) {
                                if (val.trim().isNotEmpty) {
                                  checkValidate["phoneNumber"] = true;
                                  setState(() {});
                                } else {
                                  checkValidate["phoneNumber"] = false;
                                  setState(() {});
                                }
                              },
                              prefixIcon: Icons.phone,
                              hintText: AppStrings.hintPhone,
                              validFiled: checkValidate["phoneNumber"],
                            ),
                            const SizedBox(
                              height: AppSize.s20,
                            ),
                            ButtonApp(
                                text: AppStrings.signupText,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                            (ctx)=>OTPView(
                                              User(
                                                name: firstName.text+" "+lastName.text,
                                                phoneNumber: phoneNumber.text.replaceFirst("0","+963" )
                                              )
                                            ))
                                    );
                                  }
                                }),
                            const SizedBox(
                              height: AppSize.s4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.alreadyHaveAccount,
                                  style:
                                      getRegularStyle(color: ColorManager.black),
                                ),
                                GestureDetector(
                                  onTap: () {

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => LoginView()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(AppPadding.p8),
                                    child: Text(
                                      AppStrings.loginText,
                                      style: getLightStyle(
                                          color: ColorManager.lightSecondary,
                                          fontSize: Sizer.getW(context) * 0.038),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                      )),
                )),
              ],
            ),
          Image.asset(ImagesAssets.registerBottomWave),

          ],
        ));
  }

  SafeArea buildTopContainerRegisterView(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        height: Sizer.getW(context) * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.createAccount,
              style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: Sizer.getW(context) * 0.07),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Text(
                AppStrings.registerWelcomeText,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                    color: ColorManager.white4,
                    fontSize: Sizer.getW(context) * 0.04),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
