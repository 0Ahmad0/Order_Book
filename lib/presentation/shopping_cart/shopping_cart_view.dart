import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:orderbook/translations/local_keys.g.dart';

import '../../api/auth/auth_provider.dart';

class ShoppingCartView extends StatefulWidget {
 // const ShoppingCartView({Key? key}) : super(key: key);
  final AuthProvider authProvider;
  ShoppingCartView({required this.authProvider});
  @override
  State<ShoppingCartView> createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  int numOrder = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.shoppingCart)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.builder(
              padding: EdgeInsets.only(bottom: AppSize.s70),
              itemCount: widget.authProvider.cart!.items!.length,
              itemBuilder: (_, index) {
                numOrder=int.parse("${widget.authProvider.cart!.items![index].quantity}");
                return  Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (val){

                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    margin:
                    const EdgeInsets.symmetric(vertical: AppMargin.m4),
                    decoration: BoxDecoration(
                        color: ColorManager.lightGray.withOpacity(.2),
                        borderRadius: BorderRadius.circular(AppSize.s4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Sizer.getW(context) * 0.3,
                          height: Sizer.getW(context) * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s4),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                    "${AppUrl.baseUrlImage}${ widget.authProvider.cart!.items![index].image}",
                                  ),)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                        "${widget.authProvider.cart!.items![index].name}",
                              //"Meal Name",
                              style: getBoldStyle(color: ColorManager.black,
                                  fontSize: Sizer.getW(context) * 0.035
                              ),
                            ),
                            const SizedBox(height: AppSize.s20,),
                            Text(
                              "Price : ${widget.authProvider.cart!.items![index].price}",
                              style: getRegularStyle(color: ColorManager.black,
                                  fontSize: Sizer.getW(context) * 0.03
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorManager.lightPrimary,
                              borderRadius: BorderRadius.circular(
                                  AppSize.s8
                              )
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  numOrder++;
                                  widget.authProvider.cart!.items![index].quantity="${numOrder}" ;
                                  setState((){});
                                }, icon: Icon(Icons.add,color: ColorManager.white,),),
                              Text("${widget.authProvider.cart!.items![index].quantity}",),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: (){
                                  if(numOrder>1){
                                    numOrder--;
                                    widget.authProvider.cart!.items![index].quantity="${numOrder}" ;
                                    setState((){});
                                  }
                                }, icon: Icon(Icons.remove,color: ColorManager.white,),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Text(tr(LocaleKeys.confirmOrder)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
