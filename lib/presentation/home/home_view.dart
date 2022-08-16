import 'dart:math';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/home/home_view_model.dart';
import 'package:orderbook/presentation/login/login_view.dart';
import 'package:orderbook/presentation/profile/profile_view.dart';
import 'package:orderbook/presentation/qr/qr_view.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/theme_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:story/story.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../api/auth/auth_provider.dart';
import '../../api/home/home_provider.dart';
import '../../data/local/change_theme.dart';
import '../../data/local/storage.dart';
import '../utils/const.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //HomeViewModel _homeViewModel = HomeViewModel();

  bool itemType = false;
  bool restaurantType = false;
  bool fav = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return /*ChangeNotifierProvider<HomeProvider>(
     // create: AppModel.,
      builder:
      ,)*/

      SmartRefresher(
        controller: _refreshController,
       onRefresh: ()async{
         await Future.delayed(Duration(milliseconds: 1000));
         // if failed,use refreshFailed()
         _refreshController.refreshCompleted();
       },
        child: Padding(
        padding: EdgeInsets.only(
            left: AppPadding.p14, top: AppPadding.p10, bottom: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.offers,
              style: getRegularStyle(
                  color: ColorManager.lightSecondary,
                  fontSize: Sizer.getW(context) * 0.035),
            ),
          FutureBuilder(
            future: authProvider.trendingOffers(Advance.token),
            builder: (
               context, snapshot,) {
            //  print(snapshot.error);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Const.SHOWLOADINGINDECATOR()
                );
                 //Const.CIRCLE(context);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return
                    Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: authProvider.listOffers.length,
                          itemBuilder: (_, index) {
                            return offerSection(index,context);
                          },
                        ));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
            Text(
              AppStrings.publisherItems,
              style: getRegularStyle(
                  color: ColorManager.lightSecondary,
                  fontSize: Sizer.getW(context) * 0.035),
            ),
            FutureBuilder(
              future: authProvider.trendingItems(Advance.token),
              builder: (
                  context, snapshot,) {
                //  print(snapshot.error);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(child: Const.SHOWLOADINGINDECATOR());
                  //Const.CIRCLE(context);
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: authProvider.listTrendingItems.length,
                              itemBuilder: (ctx, index) => itemsSection(index,context)));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),

            Text(
              AppStrings.publisherRestaurant,
              style: getRegularStyle(
                  color: ColorManager.lightSecondary,
                  fontSize: Sizer.getW(context) * 0.035),
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _images["img"].length,
              itemBuilder: (_, index) {
                return restaurantSection(index,context);
              },
            )),
          ],
        ),
    ),
      )
    ;
  }

  Widget offerSection(index,_) {
    return  StreamBuilder<bool>(
      builder: (context, snapshot) {
         //if(snapshot.data==null){
         //  print("Ff");

          // return SizedBox();

           return GestureDetector(
             onTap: () {
               print(index);
               print(_images["img"][index]);
               showDialog(
                   context: _, builder: (__){
                 return Dismissible(
                   direction: DismissDirection.vertical,
                   key: Key(index.toString()),
                   onDismissed: (v){
                     Navigator.pop(context);
                   },
                   child: StoryPageView(
                       onPageLimitReached: (){
                         Navigator.pop(context);
                       },
                       onPageChanged: (pageIndex){
                         index = pageIndex;
                         // _homeViewModel.onStoryChanged(pageIndex);
                        setState((){});
                       },
                       itemBuilder: (__,pageIndex,storyIndex){
                         return Stack(
                           children: [
                             Positioned.fill(
                               child: Container(color: Colors.black),
                             ),
                             Positioned.fill(
                               child: Image.asset(
                                 _images["img"][pageIndex],
                                 fit: BoxFit.cover,
                                 width: 100,
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 44, left: 8),
                               child: Row(
                                 children: [
                                   Container(
                                     height: 32,
                                     width: 32,
                                     decoration: BoxDecoration(
                                       image: DecorationImage(
                                         image: AssetImage(_images["img"][pageIndex]),
                                         fit: BoxFit.cover,
                                       ),
                                       shape: BoxShape.circle,
                                     ),
                                   ),
                                   const SizedBox(
                                     width: 8,
                                   ),
                                   Text(
                                     "RRRR${index+5}",
                                     style: TextStyle(
                                       fontSize: 17,
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         );
                       },

                       storyLength: (indexPage){
                         print(indexPage);
                         return 1;
                       },
                       pageLength: _images["img"].length
                   ),
                 );
               });
             },
             child: Container(
               width: Sizer.getW(context) * 0.27,
               margin: const EdgeInsets.symmetric(
                   horizontal: AppMargin.m4, vertical: AppMargin.m8),
               padding: const EdgeInsets.all(AppPadding.p14),
               alignment: Alignment.center,
               decoration: BoxDecoration(
                 // color: Colors.orange,
                   borderRadius: BorderRadius.circular(AppSize.s14),
                   image: DecorationImage(
                       colorFilter: ColorFilter.mode(
                           ColorManager.black.withOpacity(.6), BlendMode.darken),
                       fit: BoxFit.cover,
                       image: AssetImage(index == 0
                           ? "assets/images/img.png"
                           : _images["img"][index]))),
               child: Transform.rotate(
                 angle: 290,
                 child: Text(
                   index == 0 ? "" : "Offer ${index * 2}%",
                   textAlign: TextAlign.center,
                   style: getMediumStyle(
                       color: ColorManager.white,
                       fontSize: Sizer.getW(context) * 0.04),
                 ),
               ),
             ),
           );

      });
  }

  Widget itemsSection(index,_) {
    return Container(
      width: Sizer.getW(context) * 0.7,
      height: Sizer.getW(context) * 0.15,
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.m4, vertical: AppMargin.m8),
      padding: const EdgeInsets.all(AppPadding.p14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          // color: Colors.orange,
          borderRadius: BorderRadius.circular(AppSize.s14),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  ColorManager.black.withOpacity(.6), BlendMode.darken),
              fit: BoxFit.cover,
              image: AssetImage(index == 0
                  ? "assets/images/img.png"
                  : _images["img"][index]))),
      child: Text(
        index == 0 ? "" : "Items ${index + 1}",
        textAlign: TextAlign.center,
        style: getMediumStyle(
            color: ColorManager.white, fontSize: Sizer.getW(context) * 0.035),
      ),
    );
  }

  Widget restaurantSection(index,_) {
    return Container(
      width: Sizer.getW(context) * 0.7,
      margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.m4, vertical: AppMargin.m8),
      padding: const EdgeInsets.all(AppPadding.p14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          // color: Colors.orange,
          borderRadius: BorderRadius.circular(AppSize.s14),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  ColorManager.black.withOpacity(.6), BlendMode.darken),
              fit: BoxFit.cover,
              image: AssetImage(index == 0
                  ? "assets/images/img.png"
                  : _images["img"][index]))),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SvgPicture.asset(ImagesAssets.splashLogo),
          ),
          Text(
            index == 0 ? "" : "Restaurant ${index + 1}",
            textAlign: TextAlign.center,
            style: getMediumStyle(
                color: ColorManager.white,
                fontSize: Sizer.getW(context) * 0.035),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite ",
                  style: getRegularStyle(
                      color: ColorManager.white,
                      fontSize: Sizer.getW(context) * 0.035),
                ),
                GestureDetector(
                    onTap: (){
                      fav = !fav;
                      setState((){});
                    },
                    child: Icon(
                      fav?Icons.favorite:Icons.favorite_border
                    ))
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSize.s4, horizontal: AppSize.s8),
              decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "4",
                    style: getRegularStyle(
                        color: ColorManager.black,
                        fontSize: Sizer.getW(context) * 0.035),
                  ),
                  Icon(Icons.star)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Home View",style: getRegularStyle(
                color: ColorManager.success,fontSize:Sizer.getW(context) * 0.05
            ),),
            IconButton(onPressed: ()async{
               await AppStorage.storageWrite(
                key: AppStorage.isLoginedKEY,
                value: false
              );
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginView()));
               // print(await AppStorage.storageRead(key: AppStorage.isLoginedKEY));
            }, icon: Icon(Icons.logout)),
            Icon(Icons.ac_unit,size: 100,),
            Switch(value: Advance.theme,
              onChanged: (val)async{
              setState((){
                Advance.theme = val;
              });
              print(Advance.theme);
              await AppStorage.storageWrite(key: AppStorage.themeKEY,
                  value: Advance.theme
              );
              Get.changeTheme(getApplicationTheme(isDark:Advance.theme ));
            }),
            Switch(value: true, onChanged: (val){
            }),
          ],
        ),
      )
 */
/*
 Get.dialog(Center(
          child: Material(
            color: Colors.black,
            child: PageView.builder(
              itemCount: _images["img"].length,
              itemBuilder: (ctx, index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 15,
                      right: 15,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          _images["img"][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: Sizer.getH(context) / 2.5,
                        ),
                        Container(
                          padding: EdgeInsets.all(15.0),
                          color: ColorManager.lightPrimary,
                          child: Text(
                            "Offer ${index * 2}%",
                            style: getMediumStyle(
                                color: ColorManager.white,
                                fontSize: Sizer.getW(context) * 0.06),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ));
 */