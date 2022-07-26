import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
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

import '../../translations/local_keys.g.dart';
import '../map_tables/map_tables_view.dart';

import '../utils/const.dart';


class RestaurantProfileView extends StatefulWidget {
  final Restaurant restaurant;
  final AuthProvider authProvidere;
  const RestaurantProfileView({super.key, required this.restaurant,required this.authProvidere});

  @override
  State<RestaurantProfileView> createState() => _RestaurantProfileViewState();
}

class _RestaurantProfileViewState extends State<RestaurantProfileView> {

  AppinioSwiperController _appinioSwiperController = AppinioSwiperController();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider= Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(

        elevation: 0.0,
        title: Text(tr(LocaleKeys.restaurantProfile)),
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
            FavoriteSection(isFavorite: widget.restaurant.isFavorite!,id: widget.restaurant.id!,authProvider: authProvider,),
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
                  text: tr(LocaleKeys.menuRestaurant),
                  onTap: () async {
                    //Const.LOADIG(context);
                    //print("${AppUrl.addReservations}");
                   var result =await  widget.authProvidere.menuVendor(Advance.token,widget.restaurant.id!);
                    //var result =await  widget.authProvidere.addOrder(Advance.token);
                    //Navigator.pop(context);
                   // print(result);
                   // Const.TOAST(context,textToast: result["message"]);
                    Get.to(()=>MenuView(id: widget.restaurant.id!,id_table: -1,authProvider: widget.authProvidere,));
                  },
                ),
                const SizedBox(height: AppSize.s10,),
                ButtonApp(
                  text: tr(LocaleKeys.mapTables),
                  onTap: () async {
                    //  await  authProvider.table(Advance.token,widget.restaurant.id!);
                      // print(widget.authProvider.categories.length);
                    Get.to(()=>MapTablesView(id: widget.restaurant.id!,authProvider: authProvider,));
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
      right: Advance.language?0:null,
      left: Advance.language?null:0,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.lightGray.withOpacity(.2),
            borderRadius: BorderRadius.circular(AppSize.s50)
        ),
        child: IconButton(
          icon: Icon( widget.isFavorite?Icons.favorite:Icons.favorite_border),
          onPressed: () async {
            Const.LOADIG(context);
            Map<String, dynamic> result ={"message":"","status":""};
            print("${widget.isFavorite}");
            if( widget.isFavorite){

                result =await widget.authProvider.deleteFav(Advance.token, widget.id);
            }else{
                result =await widget.authProvider.addFav(Advance.token, widget.id);
                }
            print(result);
            Const.TOAST(context,textToast: result["message"]);
            Navigator.pop(context);
            if(result["status"]){
            widget.isFavorite = !widget.isFavorite;
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
              boxShadow: [
                BoxShadow(
                  color: ColorManager.blackF2.withOpacity(.15),
                  blurRadius: AppSize.s10
                )
              ],
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
