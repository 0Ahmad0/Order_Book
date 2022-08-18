import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/meal_details/meal_details_view.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/shopping_cart/shopping_cart_view.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../api/auth/auth_provider.dart';
import '../../domain/models.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';
import '../utils/const.dart';

class MenuView extends StatefulWidget {
  // const MenuView({Key? key}) : super(key: key);
  final int id;
  final AuthProvider authProvider;

  MenuView({required this.id, required this.authProvider});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  Map<String, dynamic> menuItems = {
    "categorys": [
      {
        "name": "Name1",
        "items": [],
        "sub_category": [1, 2, 3]
      },
      {"name": "Name2", "items": [], "sub_category": []},
      {
        "name": "Name3",
        "items": [1, 2, 3],
        "sub_category": []
      },
      {
        "name": "Name4",
        "items": [],
        "sub_category": [1, 2, 3]
      },
      {
        "name": "Name5",
        "items": [1, 2, 3],
        "sub_category": []
      },
      {
        "name": "Name6",
        "items": [1, 2, 3],
        "sub_category": []
      },
      {
        "name": "Name7",
        "items": [],
        "sub_category": [1, 2, 3]
      },
      {
        "name": "Name8",
        "items": [1, 2, 3],
        "sub_category": []
      },
    ]
  };
  int currentIndex = 0;

  @override
  Future<void> getTable() async {
    //Const.LOADIG(context);
    var result = await widget.authProvider.menuVendor(Advance.token, widget.id);
    setState(() {

    });
    //Navigator.pop(context);
    //Const.TOAST(context,textToast: result["message"]);
    // print(widget.authProvider.categories.length);
  }

  void initState() {
    // TODO: implement initState
    getTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List li = menuItems["categorys"][currentIndex]["sub_category"];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.menuRestaurant),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => ShoppingCartView());
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: Sizer.getW(context) * 0.125,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.authProvider.listCategories.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      currentIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      width: Sizer.getW(context) * 0.25,
                      padding: EdgeInsets.all(AppPadding.p10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: index == currentIndex
                                      ? ColorManager.lightPrimary
                                      : Colors.transparent,
                                  width: 2.5))),
                      child: Text(
                        //menuItems["categorys"][index]["name"],
                          widget.authProvider.listCategories[index].name!,
                        style: getRegularStyle(
                            color: index == currentIndex
                                ? ColorManager.lightPrimary
                                : ColorManager.blackF2),
                      ),
                    ),
                  );
                },
              )),
          Expanded(child: ListView(
            children: [
              if (widget.authProvider.listCategories[currentIndex].items!.length>0)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...widget.authProvider.listCategories[currentIndex].items!
                          .map((index) {
                       ;
                        //List subCat =
                        //menuItems["categorys"][index]["sub_category"];
                       // List items = menuItems["categorys"][index]["items"];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => MealDetailsView());
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppPadding.p20,
                                    vertical: AppPadding.p10
                                ),
                                height: Sizer.getW(context) * 0.45,
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                    vertical: AppMargin.m8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(AppSize.s10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(AppSize.s10)),
                                              image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                    ColorManager.black
                                                        .withOpacity(.55),
                                                    BlendMode.darken),
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    ImagesAssets.loginBackground),
                                              )),
                                        )),
                                    SizedBox(
                                      height: Sizer.getW(context) * 0.125,
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: ColorManager.blackF2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.restaurant),
                                                    Text(
                                                "${index.name}",
                                                     // " ${"Albaghel"}",
                                                      style: getRegularStyle(
                                                          color:
                                                          ColorManager.white,
                                                          fontSize: Sizer.getW(
                                                              context) *
                                                              0.035),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          VerticalDivider(
                                            color: ColorManager.white,
                                            width: 0.0,
                                          ),
                                          Expanded(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  color: ColorManager.blackF2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.monetization_on),
                                                      Text(
                                              "${index.price}",
                                                        //" ${100}\$",
                                                        style: getRegularStyle(
                                                            color: ColorManager
                                                                .white,
                                                            fontSize: Sizer.getW(
                                                                context) *
                                                                0.035),
                                                      ),
                                                    ],
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                top: (Sizer.getW(context) * 0.45) / 4,
                                right: AppSize.s16,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add_box_rounded,
                                    size: Sizer.getW(context) * 0.15,
                                  ),
                                  onPressed: () {
                                    Get.to(() => MealDetailsView());
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      })
                    ],
                  ),
                ),
              if ( widget.authProvider.listCategories[currentIndex].subCategories!.length>0)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ...widget.authProvider.listCategories[currentIndex].subCategories!
                          .map((e) {
                        print(e);
                        return Column(
                          children: [
                            ExpansionTile(
                              childrenPadding: EdgeInsets.zero,
                              title: Center(child: Text("${e}",style: getRegularStyle(color: ColorManager.lightPrimary),)),
                              children: li.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => MealDetailsView());
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AppPadding.p20,
                                            vertical: AppPadding.p10
                                        ),
                                        height: Sizer.getW(context) * 0.45,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: AppMargin.m8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(AppSize.s10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              AppSize.s10)),
                                                      image: DecorationImage(
                                                        colorFilter: ColorFilter.mode(
                                                            ColorManager.black
                                                                .withOpacity(.55),
                                                            BlendMode.darken),
                                                        fit: BoxFit.fill,
                                                        image: AssetImage(
                                                            ImagesAssets.loginBackground),
                                                      )),
                                                )),
                                            SizedBox(
                                              height: Sizer.getW(context) * 0.125,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        color: ColorManager.blackF2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Icon(Icons.restaurant),
                                                            Text(
                                                              " ${"Albaghel"}",
                                                              style: getRegularStyle(
                                                                  color: ColorManager
                                                                      .white,
                                                                  fontSize: Sizer.getW(
                                                                      context) *
                                                                      0.035),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  VerticalDivider(
                                                    color: ColorManager.white,
                                                    width: 0.0,
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                          alignment: Alignment.center,
                                                          color: ColorManager.blackF2,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Icon(Icons
                                                                  .monetization_on),
                                                              Text(
                                                                " ${100}\$",
                                                                style: getRegularStyle(
                                                                    color:
                                                                    ColorManager
                                                                        .white,
                                                                    fontSize: Sizer.getW(
                                                                        context) *
                                                                        0.035),
                                                              ),
                                                            ],
                                                          ))),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: (Sizer.getW(context) * 0.45) / 4,
                                        right: AppSize.s16,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add_box_rounded,
                                            size: Sizer.getW(context) * 0.15,
                                          ),
                                          onPressed: () {
                                            Get.to(() => MealDetailsView());
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            Divider(height: 0,)
                          ],
                        );
                      })
                    ],
                  ),
                )
              else
                Container(
                  height: Sizer.getH(context) / 1.25,
                  alignment: Alignment.center,
                  child: Text("No Data Found",style: getRegularStyle(color: ColorManager.lightPrimary),),)

            ],
          ))
        ],
      ),
    );
  }
}
