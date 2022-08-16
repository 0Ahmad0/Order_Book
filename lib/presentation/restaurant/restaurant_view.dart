import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/api/auth/auth_provider.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/restaurant_profile/restaurant_profile_view.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../api/resturant/resturants_provider.dart';
import '../../domain/models.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../utils/const.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({Key? key}) : super(key: key);

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  final search = TextEditingController();
  final List<String> places = ['1', '2', '3', '4'];
  int currentSelect = 0;
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
  GeoPoint? getPointSearch;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    //RestaurantsProvider restaurantsProvider = Provider.of<RestaurantsProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p20,
      ),
      child: Column(
        children: [
          TextFormField(
            controller: search,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorManager.lightPrimary
                )
              ),
              focusedBorder: UnderlineInputBorder(
                 borderSide: BorderSide(
                  color: ColorManager.lightPrimary,
                     width: 1.5
                 )
              ),
              disabledBorder: UnderlineInputBorder(
                 borderSide: BorderSide(
                  color: ColorManager.lightPrimary,
                     width: 1.5
                 )
              ),
              enabledBorder: UnderlineInputBorder(
                 borderSide: BorderSide(
                  color: ColorManager.lightPrimary,
                     width: 1.5
                 )
              ),
              hintText: AppStrings.search,
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                 // print("vvv");
                  currentSelect=2;
                  setState(() {

                  });
                 // print("ff");
                },
              ),
            ),
            onFieldSubmitted: (val) {
              print(val);
              print("hello Do Search Function");
            },
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          Container(
            height: Sizer.getW(context) * 0.125,
            decoration: BoxDecoration(
              color: ColorManager.lightPrimary.withOpacity(.8),
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {

                      currentSelect = 0;
                      setState(() {});
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(AppSize.s8)),
                            color: currentSelect == 0
                                ? ColorManager.lightPrimary
                                : Colors.transparent),
                        child: Text(AppStrings.rate)),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      currentSelect = 1;
                      setState(() {});
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: currentSelect == 1
                                ? ColorManager.lightPrimary
                                : Colors.transparent),
                        child: Text(AppStrings.popular)),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async{
                      currentSelect = 3;
                      setState(() {});
                      await showSimplePickerLocation(
                        context: context,
                        titleWidget: Center(
                          child: Text( AppStrings.pickLocation,style: getRegularStyle(color: ColorManager.lightPrimary,
                           fontSize: Sizer.getW(context) * 0.04,
                       ),),
                        ),
                        radius: AppSize.s14,
                        textConfirmPicker: AppStrings.pick,
                        initCurrentUserPosition: true,
                      ).then((value) {
                        print("latitude: ${value!.latitude}");
                        print("longitude: ${value.longitude}");
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(AppSize.s8)),
                            color: currentSelect == 3
                                ? ColorManager.lightPrimary
                                : Colors.transparent),
                        child: Text(AppStrings.gbs)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppSize.s4,
          ),
          FutureBuilder(
            future: authProvider.recList(Advance.token,search.text,"/33.6/36.7",currentSelect),
            builder: (
                context, snapshot,) {

              //  print(snapshot.error);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: Const.SHOWLOADINGINDECATOR(),
                  ),
                );
                //Const.CIRCLE(context);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (authProvider.recRestaurant) {
                 // print("${AppUrl.baseUrlImage}${authProvider.listRestaurant[0].imageLogo}");
                  return
                    Expanded(
                      child: ListView.builder(
                        itemCount: authProvider.listRestaurant.length,
                        itemBuilder: (_, index) {

                          return GestureDetector(
                            onTap: () {
                              print(authProvider.listRestaurant[index].images);
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (ctx) =>RestaurantProfileView(
                                      restaurant: Restaurant(
                                        imageLogo: authProvider.listRestaurant[index].imageLogo,//ImagesAssets.loginBackground,
                                        name: authProvider.listRestaurant[index].name,//"Restaurant Kallawa",
                                        isFavorite:authProvider.listRestaurant[index].isFavorite,// true,
                                        rate: authProvider.listRestaurant[index].rate,//index,
                                        address: "Damascus-Mazza",
                                        details: "Mriwed Ahmad Hariri Mohanad Hitham Heba Amer Thlaj Almasri",
                                        phoneNumber: "+963 95487296352",
                                        imagesRestaurant: authProvider.listRestaurant[index].images==null?[]:authProvider.listRestaurant[index].images,
                                      )
                                  )
                              ));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppPadding.p8),
                                  margin:
                                  const EdgeInsets.symmetric(vertical: AppMargin.m8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppSize.s14),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("assets/images/img.png"),
                                        colorFilter: ColorFilter.mode(
                                          ColorManager.black.withOpacity(.7),
                                          BlendMode.darken,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorManager.blackF2.withOpacity(.3),
                                            blurRadius: 8.0,
                                            offset: Offset(0, 4)),
                                      ]),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Hero(
                                            tag: index,
                                            child: Container(
                                              width: Sizer.getW(context) * 0.25,
                                              height: Sizer.getW(context) * 0.25,
                                              decoration: BoxDecoration(
                                                  color: ColorManager.lightPrimary
                                                      .withOpacity(.8),
                                                  borderRadius: BorderRadius.circular(
                                                      AppSize.s14),
                                                  /*image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image:
                                                       CachedNetworkImageProvider(

                                                         // "http://order-book.chi-team.com/api/storage/app/public/vendorsLogos/qNmqkRmFMOaE6qA07vCTfx4oST3HdX8iPi1MRwHA.png"
                                                       //  "https://static.vecteezy.com/system/resources/previews/000/134/503/original/free-vector-food-illustration.jpg"
                                                             "${AppUrl.baseUrlImage}${authProvider.listRestaurant[index].imageLogo}"
                                                       )

                                                     // AssetImage(ImagesAssets.tableImage)
                                                  )*/
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: "${AppUrl.baseUrlImage}${authProvider.listRestaurant[index].imageLogo}",
                                                // "https://static.vecteezy.com/system/resources/previews/000/134/503/original/free-vector-food-illustration.jpg",
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(AppSize.s14),
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                    //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                        ),
                                                  ),
                                                ),
                                                placeholder: (context, url) => Const.SHOWLOADINGINDECATOR(),
                                                errorWidget: (context, url, error) => Icon(Icons.error),
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        width: AppSize.s10,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(
                                                  (authProvider.listRestaurant[index].name==null)?"Burger King":authProvider.listRestaurant[index].name!,
                                                  style: getBoldStyle(
                                                      color: ColorManager.white,
                                                      fontSize:
                                                      Sizer.getW(context) * 0.035),
                                                ),
                                                const SizedBox(
                                                  height: AppSize.s10,
                                                ),
                                                Text(
                                                  "Restaurant",
                                                  style: getRegularStyle(
                                                      color: ColorManager.white,
                                                      fontSize:
                                                      Sizer.getW(context) * 0.035),
                                                ),
                                                const SizedBox(
                                                  height: AppSize.s10,
                                                ),
                                                Text(
                                                  "Damascus",
                                                  style: getLightStyle(
                                                      color: ColorManager.white,
                                                      fontSize: Sizer.getW(context) *
                                                          0.03),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: AppSize.s14,
                                  right: AppSize.s8,
                                  child: Container(
                                    padding: const EdgeInsets.all(AppPadding.p8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(AppSize.s14),
                                        color: ColorManager.white),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${authProvider.listRestaurant[index].rate!}",
                                        //  "5",
                                          style: getLightStyle(
                                              color: ColorManager.lightPrimary),
                                        ),
                                        Icon(
                                          Icons.star,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: AppSize.s8,
                                  bottom: AppSize.s16,
                                  child: CircleAvatar(
                                      backgroundColor: ColorManager.lightPrimary,
                                      child: LikeButton(

                                      )
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),

        ],
      ),
    );
  }
}
