import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/shopping_cart/shopping_cart_view.dart';
import 'package:orderbook/presentation/utils/sizer.dart';

import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';

class MealDetailsView extends StatefulWidget {
  const MealDetailsView({Key? key}) : super(key: key);

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  int numMeals = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: Sizer.getW(context) * 0.15,
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p18, vertical: AppPadding.p8),
            margin: const EdgeInsets.all(AppMargin.m10),
            decoration: BoxDecoration(
                color: ColorManager.lightPrimary,
                borderRadius: BorderRadius.circular(AppSize.s100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  "${numMeals*100}\$",
                  style: getBoldStyle(
                      color: ColorManager.white,
                      fontSize: Sizer.getW(context) * 0.035),
                )),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppPadding.p4),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.white),
                          borderRadius: BorderRadius.circular(AppSize.s100)),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (numMeals > 1) {
                                  numMeals--;
                                  setState(() {});
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                color: ColorManager.white,
                              )),
                          Text("${numMeals}"),
                          IconButton(
                              onPressed: () {
                                numMeals++;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.add,
                                color: ColorManager.white,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(AppSize.s4)),
                      child: IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          Get.to(()=>ShoppingCartView());
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    ImagesAssets.loginBackground,
                    color: ColorManager.blackF2.withOpacity(.2),
                    colorBlendMode: BlendMode.darken,
                    width: double.infinity,
                    height: Sizer.getW(context) * 0.6,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: AppSize.s4,
                    left: Advance.language?AppSize.s10:null,
                    right: Advance.language?null:AppSize.s10,
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          shape: BoxShape.circle
                        ),
                          child: BackButton()),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20,
                  vertical: AppPadding.p30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Meal Name",
                      style: getBoldStyle(
                          color: ColorManager.blackF2,
                          fontSize: Sizer.getW(context) * 0.045),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Container(
                      child: Text(
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri"
                        "Ahmad Mohamed Hariri",
                        style: getRegularStyle(color: ColorManager.lightGray),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
