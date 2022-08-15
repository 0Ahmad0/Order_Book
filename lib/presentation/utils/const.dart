
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'sizer.dart';

class Const{
  static LOADIG(context){
    Get.dialog(Center(
      child: Container(
          alignment: Alignment.center,
          width: Sizer.getW(context) * 0.2,
          height: Sizer.getW(context) * 0.2,
          decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s8)),
          child: LoadingAnimationWidget.inkDrop(
              color: ColorManager.lightPrimary,
              size: Sizer.getW(context) * 0.1)),
    ));
  }

  static TOAST(BuildContext context,{String textToast = "This Is Toast"}){
    showToast(
        textToast,
      context: context,
    animation:StyledToastAnimation.fadeScale,
      textStyle: getRegularStyle(color: ColorManager.white)
    );

  }
}