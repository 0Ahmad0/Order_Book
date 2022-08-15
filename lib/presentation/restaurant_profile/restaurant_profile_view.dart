import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/location_restaurant_map/location_restaurant_map_view.dart';
import 'package:orderbook/presentation/login/login_view.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';


class RestaurantProfileView extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantProfileView({super.key, required this.restaurant});

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
            FavoriteSection(isFavorite: widget.restaurant.isFavorite!,),
            Column(
              children: <Widget>[
                Hero(
                    tag: widget.restaurant.rate!,
                    child: InkWell(
                      onTap: (){
                        Get.dialog(
                          Center(
                            child: Image.asset(
                              widget.restaurant.imageLogo!,
                              width: double.infinity,
                              height: Sizer.getW(context),
                            ),
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
                                image: AssetImage(widget.restaurant.imageLogo!))),
                      ),
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
                    const Divider(
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
                        )),
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
                    ListTile(
                        leading: Icon(Icons.details),
                        title: Text(
                          widget.restaurant.details!,
                          style: getRegularStyle(
                              color: ColorManager.blackF2,
                              fontSize: Sizer.getW(context) * 0.03),
                        )),

                  ],
                ),
                SwipedCardSection(
                  cards: widget.restaurant.imagesRestaurant!,
                ),
                const SizedBox(height: AppSize.s20,),
                Expanded(
                  child: ButtonApp(
                    text: "Mune",
                    onTap: (){},
                  ),
                ),
                const SizedBox(height: AppSize.s10,),
                Expanded(
                  child: ButtonApp(
                    text: "Restaurant Map",
                    onTap: (){},
                  ),
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

   FavoriteSection({super.key, required this.isFavorite});
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
          onPressed: (){
            widget.isFavorite = !widget.isFavorite;
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
                  image: AssetImage(e)
              )
          ),
        )
        ).toList(),
      ),
    );

  }
}
