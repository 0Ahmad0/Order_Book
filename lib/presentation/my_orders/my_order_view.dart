import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/restaurant_map_scroll/restaurant_map_scroll_view.dart';
import 'package:easy_localization/easy_localization.dart';


class MyOrdersView extends StatefulWidget {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p20,
        vertical: AppPadding.p10,
      ),
      child: ListView(
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
                  title: Text(AppStrings.currentOrders),
                  children: List.generate(
                      1,
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
                                    text:
                                        "Price Order : ${30500}",
                                    icon: Icons.monetization_on),
                                Divider(
                                  height: 0,
                                ),
                                buildListTile(
                                    text:
                                        "Notes : ${
                                        "acsascmamsocmascomaosmcoamsomcs"
                                            "acsmaocsmaoscmoamscoasomoascmaca"
                                            "acsmsaocmoascmomascomasc"
                                        }",
                                    icon: Icons.date_range),
                              ],
                            ),
                          )),
                ),
              )),
          const SizedBox(height: AppSize.s20,),
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
                                    text:
                                        "Price Order : ${30500}",
                                    icon: Icons.monetization_on),
                                Divider(
                                  height: 0,
                                ),
                                buildListTile(
                                    text:
                                        "Notes : ${
                                        "acsascmamsocmascomaosmcoamsomcs"
                                            "acsmaocsmaoscmoamscoasomoascmaca"
                                            "acsmsaocmoascmomascomasc"
                                        }",
                                    icon: Icons.date_range),
                              ],
                            ),
                          )),
                ),
              )),
        ],
      ),
    );
  }

  buildListTile({icon, text}) {
    return ListTile(
      dense: true,
      onTap: () {},
      leading: Icon(icon),
      title: Text(
        text,
       style: getRegularStyle(
           color: ColorManager.lightPrimary, fontSize: AppSize.s12),
      ),
    );
  }
}
