import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/presentation/meal_details/meal_details_view.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../api/auth/auth_provider.dart';
import '../../domain/models.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../resources/values_manager.dart';

class MenuView extends StatefulWidget {
 // const MenuView({Key? key}) : super(key: key);
  final int id;
  final AuthProvider authProvider;
  MenuView({required this.id,required this.authProvider});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  List<String> menuItems = [
    "All",
    "Cold",
    "Hot",
    "Meat",
    "Shawarma",
    "checkin",
    "Fish",
  ];
  int currentIndex = 0;
  @override
  Future<void> getTable() async {
    await  widget.authProvider.menuVendor(Advance.token,widget.id);
    // print(widget.authProvider.categories.length);
  }
  void initState() {
    // TODO: implement initState
    getTable();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.menuRestaurant),
        elevation: 0.0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: Sizer.getW(context) * 0.125,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menuItems.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      print(menuItems[index]);
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
                        menuItems[index],
                        style: getRegularStyle(
                            color: index == currentIndex
                                ? ColorManager.lightPrimary
                                : ColorManager.blackF2),
                      ),
                    ),
                  );
                },
              )),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p20, vertical: AppPadding.p10),
              itemCount: 15,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(()=>MealDetailsView());

                  },
                  child: Stack(
                    children: [
                      Container(
                        height: Sizer.getW(context) * 0.45,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: AppMargin.m8),
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(AppSize.s10)
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.2),
                                blurRadius: 8,
                                offset: Offset(0, 4))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(AppSize.s10)
                                  ),
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        ColorManager.black.withOpacity(.55),
                                        BlendMode.darken),
                                    fit: BoxFit.fill,
                                    image: AssetImage(ImagesAssets.loginBackground),
                                  )
                              ),
                            )),
                            SizedBox(
                              height: Sizer.getW(context) * 0.125,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      flex:2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: ColorManager.blackF2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.restaurant),
                                            Text(" ${"Albaghel"}",style: getRegularStyle(
                                                color: ColorManager.white,
                                                fontSize: Sizer.getW(context) * 0.035
                                            ),),
                                          ],
                                        ),
                                      )),
                                  VerticalDivider(
                                    color: ColorManager.white,
                                    width: 0.0,
                                  ),
                                  Expanded(child: Container(
                                      alignment: Alignment.center,
                                      color: ColorManager.blackF2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.monetization_on),
                                          Text(" ${100}\$",style: getRegularStyle(
                                              color: ColorManager.white,
                                              fontSize: Sizer.getW(context) * 0.035
                                          ),),
                                        ],
                                      )
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: (Sizer.getW(context) * 0.45)/4,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.add_box_rounded,size: Sizer.getW(context) * 0.15,),
                          onPressed: (){
                            Get.to(()=>MealDetailsView());
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
