
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderbook/presentation/add_reservations/add_reservations_view.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class MyReservationsView extends StatefulWidget {
  const MyReservationsView({Key? key}) : super(key: key);

  @override
  State<MyReservationsView> createState() => _MyReservationsViewState();
}

class _MyReservationsViewState extends State<MyReservationsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: AppPadding.p10, horizontal: AppPadding.p20),
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
                    title: Text(AppStrings.currentReservation),
                    children: List.generate(
                        1,
                        (index) => Card(
                              margin: const EdgeInsets.all(AppMargin.m8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildListTile(
                                      text:
                                          "Table Number : ${index * 8 + 2 * 5}",
                                      icon: Icons.table_restaurant),
                                  Divider(
                                    height: 0,
                                  ),
                                  buildListTile(
                                      text: "Persons Number : ${index + 5 * 2}",
                                      icon: Icons.groups),
                                  Divider(
                                    height: 0,
                                  ),

                                  buildListTile(
                                      text:
                                          "Restaurant Name : R${index + 5 * 2}",
                                      icon: Icons.restaurant_menu),
                                  Divider(
                                    height: 0,
                                  ),
                                  buildListTile(
                                      text:
                                          "Date Of Reservation : ${DateFormat.yMd().add_jms().format(DateTime.now())}",
                                      icon: Icons.date_range),
                                ],
                              ),
                            )),
                  ),
                )),
            SizedBox(
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
                    title: Text(AppStrings.pendingReservation),
                    children: List.generate(
                        3,
                            (index) => Card(
                              margin: const EdgeInsets.all(AppMargin.m8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildListTile(
                                      text:
                                      "Table Number : ${index * 8 + 2 * 5}",
                                      icon: Icons.table_restaurant),
                                  Divider(
                                    height: 0,
                                  ),
                                  buildListTile(
                                      text: "Persons Number : ${index + 5 * 2}",
                                      icon: Icons.groups),
                                  Divider(
                                    height: 0,
                                  ),

                                  buildListTile(
                                      text:
                                      "Restaurant Name : R${index + 5 * 2}",
                                      icon: Icons.restaurant_menu),
                                  Divider(
                                    height: 0,
                                  ),
                                  buildListTile(
                                      text:
                                      "Date Of Reservation : ${DateFormat.yMd().add_jms().format(DateTime.now())}",
                                      icon: Icons.date_range),
                                ],
                              ),
                            )),
                  ),
                )),
            SizedBox(
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
                    title: Text(AppStrings.expiredReservation),
                    children: List.generate(
                        8,
                            (index) => Card(
                              margin: const EdgeInsets.all(AppMargin.m8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildListTile(
                                      text:
                                      "Table Number : ${index * 8 + 2 * 5}",
                                      icon: Icons.table_restaurant),
                                  Divider(
                                    height: 0,
                                  ),
                                  buildListTile(
                                      text: "Persons Number : ${index + 5 * 2}",
                                      icon: Icons.groups),
                                  Divider(
                                    height: 0,
                                  ),

                                  buildListTile(
                                      text:
                                      "Restaurant Name : R${index + 5 * 2}",
                                      icon: Icons.restaurant_menu),
                                  Divider(
                                    height: 0,
                                  ),
                                  buildListTile(
                                      text:
                                      "Date Of Reservation : ${DateFormat.yMd().add_jms().format(DateTime.now())}",
                                      icon: Icons.date_range),
                                ],
                              ),
                            ))
                  ),
                )),
          ],
        ));
  }

  buildListTile({icon, text}) {
    return ListTile(

      dense: true,
      onTap: (){},
      leading: Icon(icon),
      title: Text(
        text,
        style: getRegularStyle(
          color: ColorManager.lightPrimary,
          fontSize: AppSize.s12
        ),
      ),
    );
  }
}
/*
FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddReservationsView()));
        },
      ),
 */
