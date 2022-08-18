import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/api/resturant/resturants_provider.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/shopping_cart/shopping_cart_view.dart';
import 'package:orderbook/presentation/utils/const.dart';
import 'package:orderbook/presentation/utils/sizer.dart';

import '../../api/app_url/app_url.dart';
import '../../api/auth/auth_provider.dart';
import '../resources/strings_manager.dart';
import '../resources/style_manager.dart';

class MealDetailsView extends StatefulWidget {
  //const MealDetailsView({Key? key}) : super(key: key);
  final AuthProvider authProvider;
  Item item;
  MealDetailsView({required this.authProvider,required this.item});
  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  int numMeals = 1;
  @override
  Widget build(BuildContext context) {
    print(widget.authProvider.cart!.table_id);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          (widget.authProvider.cart!.table_id!<0)?(SizedBox()):Container(
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
                      (widget.item!=null)?"${widget.item.price}":"-",
                 // "${numMeals*100}\$",
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
                          widget.item.quantity="${numMeals}";
                          bool check=false;
                          for(Item element in widget.authProvider.cart!.items!){
                            if(element.id==widget.item.id){
                              check=true;
                              element.quantity=widget.item.quantity!;
                            }
                          }
                          if(!check){
                            widget.authProvider.cart!.items!.add(widget.item);
                           RestaurantsProvider.carts!.items!.add(widget.item);
                          }
                          print(widget.authProvider.cart!.items!.length);
                          Navigator.pop(context);

                          //Get.to(()=>kBottomNavigationBarHeight);
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
                  CachedNetworkImage(
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: Sizer.getW(context) * 0.6,
                    imageUrl:
                    "${AppUrl.baseUrlImage}${widget.item.image}",
                    // "https://static.vecteezy.com/system/resources/previews/000/134/503/original/free-vector-food-illustration.jpg",
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        Const.SHOWLOADINGINDECATOR(),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  ),
                  /*Image.asset(
                    ImagesAssets.loginBackground,
                    color: ColorManager.blackF2.withOpacity(.2),
                    colorBlendMode: BlendMode.darken,
                    width: double.infinity,
                    height: Sizer.getW(context) * 0.6,
                    fit: BoxFit.fill,
                  ),*/
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
                      "${widget.item.name}",
                     // "Meal Name",
                      style: getBoldStyle(
                          color: ColorManager.blackF2,
                          fontSize: Sizer.getW(context) * 0.045),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Container(
                      child: Text(
                        (widget.item!=null)?"${widget.item.description}":"-------------------",
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
