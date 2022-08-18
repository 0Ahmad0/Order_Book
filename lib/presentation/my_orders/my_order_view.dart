import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/restaurant_map_scroll/restaurant_map_scroll_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import '../../api/auth/auth_provider.dart';

import '../../api/app_url/app_url.dart';
import '../../domain/models.dart';
import '../utils/const.dart';
import '../utils/sizer.dart';

class MyOrdersView extends StatefulWidget {
  //const MyOrdersView({Key? key}) : super(key: key);
 late AuthProvider authProvider;
  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  @override
  Widget build(BuildContext context) {
    widget.authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: FutureBuilder(
        future: widget.authProvider.myOrders(Advance.token),
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
                ListView(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s14),
                            color: ColorManager.lightGray.withOpacity(.2)),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.zero,
                            initiallyExpanded: true,
                            title: Text("Pending Orders"/*AppStrings.currentOrders*/),
                            children: List.generate(
                                widget.authProvider.listPendingOrders.length,
                                    (index) => Card(
                                  margin: const EdgeInsets.all(AppMargin.m8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListTile(
                                          text:
                                          "Order Number : ${widget.authProvider.listPendingOrders[index].id}",
                                          icon: Icons.food_bank_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Num Orders : ${(widget.authProvider.listPendingOrders[index].offers!.length+
                                              widget.authProvider.listPendingOrders[index].item!.length)}",
                                          icon: Icons.numbers_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text:
                                          "Restaurant Name : ${widget.authProvider.listPendingOrders[index].name}",
                                          icon: Icons.restaurant_menu),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Price Order : ${widget.authProvider.getPrice(index)}",
                                          icon: Icons.monetization_on),
                                      Divider(
                                        height: 0,
                                      ),

                                    ],
                                  ),
                                )),
                          ),
                        )),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s14),
                            color: ColorManager.lightGray.withOpacity(.2)),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.zero,
                            initiallyExpanded: true,
                            title: Text("ServedOrders"/*AppStrings.currentOrders*/),
                            children: List.generate(
                                widget.authProvider.listServedOrders.length,
                                    (index) => Card(
                                  margin: const EdgeInsets.all(AppMargin.m8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListTile(
                                          text:
                                          "Order Number : ${widget.authProvider.listServedOrders[index].id}",
                                          icon: Icons.food_bank_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Num Orders : ${(widget.authProvider.listServedOrders[index].offers!.length+
                                              widget.authProvider.listServedOrders[index].item!.length)}",
                                          icon: Icons.numbers_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text:
                                          "Restaurant Name : ${widget.authProvider.listServedOrders[index].name}",
                                          icon: Icons.restaurant_menu),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Price Order : ${widget.authProvider.getPrice(index)}",
                                          icon: Icons.monetization_on),
                                      Divider(
                                        height: 0,
                                      ),

                                    ],
                                  ),
                                )),
                          ),
                        )),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s14),
                            color: ColorManager.lightGray.withOpacity(.2)),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.zero,
                            initiallyExpanded: true,
                            title: Text("Rejected Orders"/*AppStrings.currentOrders*/),
                            children: List.generate(
                                widget.authProvider.listRejectedOrders.length,
                                    (index) => Card(
                                  margin: const EdgeInsets.all(AppMargin.m8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListTile(
                                          text:
                                          "Order Number : ${widget.authProvider.listRejectedOrders[index].id}",
                                          icon: Icons.food_bank_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Num Orders : ${(widget.authProvider.listRejectedOrders[index].offers!.length+
                                              widget.authProvider.listRejectedOrders[index].item!.length)}",
                                          icon: Icons.numbers_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text:
                                          "Restaurant Name : ${widget.authProvider.listRejectedOrders[index].name}",
                                          icon: Icons.restaurant_menu),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Price Order : ${widget.authProvider.getPrice(index)}",
                                          icon: Icons.monetization_on),
                                      Divider(
                                        height: 0,
                                      ),

                                    ],
                                  ),
                                )),
                          ),
                        )),
                    const SizedBox(
                      height: AppSize.s20,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s14),
                            color: ColorManager.lightGray.withOpacity(.2)),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.zero,
                            initiallyExpanded: true,
                            title: Text("Cancelled Orders"/*AppStrings.currentOrders*/),
                            children: List.generate(
                                widget.authProvider.listCancelledOrders.length,
                                    (index) => Card(
                                  margin: const EdgeInsets.all(AppMargin.m8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListTile(
                                          text:
                                          "Order Number : ${widget.authProvider.listCancelledOrders[index].id}",
                                          icon: Icons.food_bank_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Num Orders : ${(widget.authProvider.listCancelledOrders[index].offers!.length+
                                              widget.authProvider.listCancelledOrders[index].item!.length)}",
                                          icon: Icons.numbers_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text:
                                          "Restaurant Name : ${widget.authProvider.listCancelledOrders[index].name}",
                                          icon: Icons.restaurant_menu),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Price Order : ${widget.authProvider.getPrice(index)}",
                                          icon: Icons.monetization_on),
                                      Divider(
                                        height: 0,
                                      ),

                                    ],
                                  ),
                                )),
                          ),
                        )),

    /* Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s14),
                            color: ColorManager.lightGray.withOpacity(.2)),


                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.zero,
                            title: Text(AppStrings.previousOrders),
                            children: List.generate(
                                5,
                                    (index) => Card(
                                  margin: const EdgeInsets.all(AppMargin.m8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      buildListTile(
                                          text: "Order Number : ${index * 8 + 2 * 5}",
                                          icon: Icons.food_bank_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Num Orders : ${index + 5 * 2}",
                                          icon: Icons.numbers_rounded),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Restaurant Name : R${index + 5 * 2}",
                                          icon: Icons.restaurant_menu),
                                      Divider(
                                        height: 0,
                                      ),
                                      buildListTile(
                                          text: "Price Order : ${30500}",
                                          icon: Icons.monetization_on),
                                      Divider(
                                        height: 0,
                                      ),

                                    ],
                                  ),
                                )),
                          ),
                        )),
                    */
                  ],
                );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  buildListTile({icon, text}) {
    return ListTile(
      dense: true,
      onTap: () {
        Get.dialog(Center(
          child: Container(
            padding: EdgeInsets.all(AppPadding.p10),
            margin: EdgeInsets.symmetric(
              horizontal: AppMargin.m20,
              vertical: AppMargin.m10,
            ),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius:
              BorderRadius.circular(AppSize.s14),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Text(
                    "Items",
                    style:
                    getBoldStyle(color: ColorManager.lightPrimary,
                        fontSize: Sizer.getW(context) * 0.05                                             ),
                  ),
                  Divider(),
                  Expanded(child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (_,index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: AppMargin.m10),
                            width: Sizer.getW(context) *
                                0.3,
                            height: Sizer.getW(context)
                                * 0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.s14),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        ImagesAssets.loginBackground
                                    )
                                )
                            ),),
                          Text("Name",style: getRegularStyle(
                              color: ColorManager.lightPrimary
                          ),),
                          Text("Quantity",style: getRegularStyle(
                              color: ColorManager.lightPrimary
                          ),),
                        ],
                      );
                    },
                  ))
                ],
              ),
            ),
          ),
        ));

      },
      leading: Icon(icon),
      title: Text(
        text,
        style: getRegularStyle(
            color: ColorManager.lightPrimary, fontSize: AppSize.s12),
      ),
    );
  }
}
