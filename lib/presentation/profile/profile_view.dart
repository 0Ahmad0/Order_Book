import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderbook/data/local/storage.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/login/login_view.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';

import '../resources/style_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final phoneNumber = TextEditingController(text: "+963 954872922");
  final name = TextEditingController(text: "Ahmad Alhariri");
  bool type = false;
  Map _images = {
    "img": [
      "assets/images/5.jpg",
      "assets/images/2.jpg",
      "assets/images/3.jpg",
      "assets/images/4.jpg",
      "assets/images/5.jpg",
      "assets/images/4.jpg",
      "assets/images/2.jpg",
      "assets/images/3.jpg",
      "assets/images/5.jpg",
      "assets/images/4.jpg",
      "assets/images/2.jpg",
      "assets/images/3.jpg",
      "assets/images/2.jpg",
      "assets/images/2.jpg",
      "assets/images/2.jpg",
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppStrings.profileText),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  Hero(
                    tag: Advance.avatarImage,
                    child: Container(
                      width: Sizer.getW(context) * 0.3,
                      height: Sizer.getW(context) * 0.3,
                      padding: const EdgeInsets.all(AppPadding.p8),
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(Advance.avatarImage)),
                          boxShadow: [
                            BoxShadow(
                                color: ColorManager.blackF2.withOpacity(.2),
                                offset: Offset(0, AppSize.s4),
                                blurRadius: AppSize.s10)
                          ]),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                        onTap: () {
                          Get.bottomSheet(Container(
                            padding: const EdgeInsets.all(AppPadding.p16),
                            width: double.infinity,
                            height: Sizer.getH(context) * 0.45,
                            decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(AppSize.s50))),
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.2,
                                ),
                                itemCount: ImagesAssets.avatarImages.length,
                                itemBuilder: (_, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await AppStorage.storageWrite(
                                          key: AppStorage.avatarKEY,
                                          value:
                                              ImagesAssets.avatarImages[index]);
                                      print(await AppStorage.storageRead(
                                          key: AppStorage.avatarKEY));
                                      Advance.avatarImage =
                                          await AppStorage.storageRead(
                                              key: AppStorage.avatarKEY);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: Sizer.getW(context) * 0.25,
                                      height: Sizer.getW(context) * 0.25,
                                      padding:
                                          const EdgeInsets.all(AppPadding.p8),
                                      margin:
                                          const EdgeInsets.all(AppMargin.m4),
                                      decoration: BoxDecoration(
                                          color:  Advance.avatarImage == ImagesAssets
                                              .avatarImages[index]
                                              ? ColorManager.lightPrimary
                                              :ColorManager.white,
                                          shape: BoxShape.circle,

                                          image: DecorationImage(
                                              image: AssetImage(ImagesAssets
                                                  .avatarImages[index])),
                                          boxShadow: [
                                            BoxShadow(
                                                color: ColorManager.blackF2
                                                    .withOpacity(.2),
                                                offset: Offset(0, AppSize.s4),
                                                blurRadius: AppSize.s10)
                                          ]),
                                    ),
                                  );
                                  ;
                                }),
                          ));
                        },
                        child: Container(
                            padding: EdgeInsets.all(AppSize.s10),
                            decoration: BoxDecoration(
                                color: ColorManager.lightPrimary,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.edit,
                              color: ColorManager.white,
                              size: AppSize.s16,
                            ))),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSize.s20,
            ),
            CustomTextFiled(
              controller: name,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLength: null,
              validator: (val) {
                if (val!.trim().isEmpty) {
                  return AppStrings.fieldNotEmpty;
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
              prefixIcon: Icons.edit,
              hintText: AppStrings.name,
              validFiled: type,
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            IgnorePointer(
              ignoring: true,
              child: CustomTextFiled(
                controller: phoneNumber,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                maxLength: null,
                onChange: null,
                validator: null,
                prefixIcon: Icons.phone,
                hintText: AppStrings.hintPhone,
                validFiled: false,
              ),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
            ButtonApp(
                text: " Save ",
                onTap: () {
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
                  Timer(Duration(milliseconds: 1500), () {
                    Navigator.pop(context);
                  });
                }),
            const SizedBox(
              height: AppSize.s10,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                  alignment: Alignment.center,
                  height: Sizer.getW(context) * 0.15,
                  decoration: BoxDecoration(
                        color: ColorManager.lightPrimary.withOpacity(.85),
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(AppSize.s8))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.restaurant,color: ColorManager.white,),
                        Text(
                          "Fovarite Restaurant",
                          style: getRegularStyle(color: ColorManager.white,
                          ),
                        ),
                      ],
                  ),
                ),
                    )),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Expanded(
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        height: Sizer.getW(context) * 0.15,
                        decoration: BoxDecoration(
                            color: ColorManager.lightPrimary.withOpacity(.85),
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(AppSize.s8))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.report,color: ColorManager.white,),
                            Text(
                              AppStrings.reports,
                              style: getRegularStyle(color: ColorManager.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),

              ],
            )
          ],
        ),
      ),
    );
  }
}
/*
  Text(AppStrings.favoriteRestaurent,
            style: getRegularStyle(color: ColorManager.lightPrimary),
            ),
            Expanded(child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: _images["img"].length,
                itemBuilder: (_,index){
                  return Container(
                    width: Sizer.getW(context) * 0.5,
                    padding: const EdgeInsets.all(AppPadding.p12),
                    margin: EdgeInsets.only(
                      left: AppMargin.m8
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(_images["img"][index])
                      )
                    ),
                  );
                })),
            const SizedBox(height: AppSize.s10,),
            Text(AppStrings.favoriteRestaurent,
              style: getRegularStyle(color: ColorManager.lightPrimary),
            ),
            Expanded(child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: _images["img"].length,
                itemBuilder: (_,index){
                  return Container(
                    width: Sizer.getW(context) * 0.5,
                    padding: const EdgeInsets.all(AppPadding.p12),
                    margin: EdgeInsets.only(
                      left: AppMargin.m8
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(_images["img"][index])
                      )
                    ),
                  );
                })),
 */