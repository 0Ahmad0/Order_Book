import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/location_restaurant_map/location_restaurant_map_view.dart';
import 'package:orderbook/presentation/login/login_view.dart';
import 'package:orderbook/presentation/menu/menu_view.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../api/app_url/app_url.dart';
import '../../api/auth/auth_provider.dart';
import '../../api/resturant/resturants_provider.dart';
import '../map_tables/map_tables_view.dart';
import '../utils/const.dart';


class RestaurantProfileView extends StatefulWidget {
  final Restaurant restaurant;
  final AuthProvider authProvider;
  const RestaurantProfileView({super.key, required this.restaurant,required this.authProvider});

  @override
  State<RestaurantProfileView> createState() => _RestaurantProfileViewState();
}

class _RestaurantProfileViewState extends State<RestaurantProfileView> {

  AppinioSwiperController _appinioSwiperController = AppinioSwiperController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(AppStrings.restaurantProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p10),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(AppPadding.p10),
              decoration: BoxDecoration(
                color: ColorManager.lightGray.withOpacity(.2),
                borderRadius: BorderRadius.circular(AppSize.s50)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star),
                  const SizedBox(height: AppSize.s14,),
                  Text("${widget.restaurant.rate!}",style: TextStyle(
                    color: ColorManager.lightPrimary
                  ),)
                ],
              ),
            ),
            FavoriteSection(isFavorite: widget.restaurant.isFavorite!,id: widget.restaurant.id!,authProvider: widget.authProvider,),
            Column(
              children: <Widget>[
                Hero(
                    tag: widget.restaurant.rate!,
                    child: InkWell(
                      onTap: (){
                        Get.dialog(
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Spacer(),

                                CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: Sizer.getW(context) * 0.7,
                                  imageUrl:
                                  "${AppUrl.baseUrlImage}${widget.restaurant.imageLogo!}",
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
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                Spacer(),
                              ],
                            ),
                            /*Image.asset(
                              widget.restaurant.imageLogo!,
                              width: double.infinity,
                              height: Sizer.getW(context),
                            ),*/
                          )
                        );
                      },
                      child: Container(
                        width: Sizer.getW(context) * 0.25,
                        height: Sizer.getW(context) * 0.25,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:CachedNetworkImageProvider("${
                                    AppUrl.baseUrlImage}${
                                    widget.restaurant.imageLogo}",),// AssetImage(widget.restaurant.imageLogo!)
                            )), ),
                    )),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.restaurant),
                      title: Text(
                        widget.restaurant.name!,
                        style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: Sizer.getW(context) * 0.04),
                      ),
                    ),
                    /*const Divider(
                      height: 0.0,
                      color: ColorManager.lightGray,
                    ),
                    ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(
                          "${widget.restaurant.phoneNumber!}",
                          style: getRegularStyle(
                              color: ColorManager.blackF2,
                              fontSize: Sizer.getW(context) * 0.035),
                        )),*/
                    const Divider(
                      height: 0.0,
                      color: ColorManager.lightGray,
                    ),
                    ListTile(
                      onTap: (){
                        Get.to(()=>RestaurantLocationView(
                            latitude:33.51592843335949,
                            longitude: 36.31083943986069
                        ));
                      },
                        leading: Icon(Icons.location_pin),
                        title: Text(
                          widget.restaurant.address!,
                          style: getRegularStyle(
                              color: ColorManager.blackF2,
                              fontSize: Sizer.getW(context) * 0.035),
                        )),
                    const Divider(
                      height: 0.0,
                      color: ColorManager.lightGray,
                    ),
                    /*ListTile(
                        leading: Icon(Icons.details),
                        title: Text(
                          widget.restaurant.details!,
                          style: getRegularStyle(
                              color: ColorManager.blackF2,
                              fontSize: Sizer.getW(context) * 0.03),
                        )),
                    */
                  ],
                ),
                SwipedCardSection(
                  cards: widget.restaurant.imagesRestaurant!,
                ),
                const SizedBox(height: AppSize.s20,),
                ButtonApp(
                  text: "Menu",
                  onTap: (){
                    Get.to(()=>MenuView());
                  },
                ),
                const SizedBox(height: AppSize.s10,),
                ButtonApp(
                  text: "Restaurant Map",
                  onTap: (){
                    Get.to(()=>MapTablesView());
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
class FavoriteSection extends StatefulWidget {
   bool isFavorite;
   int id;
   AuthProvider authProvider;
   FavoriteSection({super.key, required this.isFavorite,required this.id,required this.authProvider});
  @override
  State<FavoriteSection> createState() => _FavoriteSectionState();
}

class _FavoriteSectionState extends State<FavoriteSection> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.lightGray.withOpacity(.2),
            borderRadius: BorderRadius.circular(AppSize.s50)
        ),
        child: IconButton(
          icon: Icon( widget.isFavorite?Icons.favorite:Icons.favorite_border),
          onPressed: () async {
            Const.LOADIG(context);
            var result =await widget.authProvider.addFav(Advance.token, widget.id);
            print(result);
            Const.TOAST(context,textToast: result["message"]);
            Navigator.pop(context);
            if(result["status"]){
              widget.isFavorite = !widget.isFavorite;
              /// SnackBar(content: Text("k"));
              //print("done register");
              // Const.TOAST(context,textToast: result["message"]);
            }else{
              /// SnackBar(content: Text("o"));

            }

            setState((){});
          },
        ),
      ),
    );

  }
}

class SwipedCardSection extends StatefulWidget {

  final List cards;
  const SwipedCardSection({super.key, required this.cards,});
  @override
  State<SwipedCardSection> createState() => _SwipedCardSectionState();
}

class _SwipedCardSectionState extends State<SwipedCardSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: AppinioSwiper(
        onSwipe: (index){
          print(index);
          if(index == 0 ){
            setState((){});
          }
        },
        cards: widget.cards.map((e)
        => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s14),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider("${AppUrl.baseUrlImage}${e['image']}",),//AssetImage(e)
              )
          ),
        )
        ).toList(),
      ),
    );

  }
}
