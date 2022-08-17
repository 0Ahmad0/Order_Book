
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderbook/presentation/add_reservations/add_reservations_view.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:provider/provider.dart';

import '../../api/auth/auth_provider.dart';
import '../../domain/models.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../utils/const.dart';

class MyReservationsView extends StatefulWidget {
  const MyReservationsView({Key? key}) : super(key: key);

  @override
  State<MyReservationsView> createState() => _MyReservationsViewState();
}

class _MyReservationsViewState extends State<MyReservationsView> {
  late AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
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
                        authProvider.listAcceptedReservations.length,
                            (index) => Card(
                          margin: const EdgeInsets.all(AppMargin.m8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildListTile(
                                  text:
                                  "Table Number : ${authProvider.listAcceptedReservations[index].id}",
                                  icon: Icons.table_restaurant),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text: "Persons Number : ${authProvider.listAcceptedReservations[index].number_of_people}",
                                  icon: Icons.groups),
                              Divider(
                                height: 0,
                              ),

                              buildListTile(
                                  text:
                                  "Restaurant Name : ${authProvider.listAcceptedReservations[index].name}",
                                  icon: Icons.restaurant_menu),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text:
                                  "Date Of Reservation : ${authProvider.listAcceptedReservations[index].date}",
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
                    childrenPadding: EdgeInsets.zero,
                    title: Text(AppStrings.currentReservation),
                    children: List.generate(
                        authProvider.listAcceptedReservations.length,
                            (index) => Card(
                          margin: const EdgeInsets.all(AppMargin.m8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildListTile(
                                  text:
                                  "Table Number : ${authProvider.listAcceptedReservations[index].id}",
                                  icon: Icons.table_restaurant),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text: "Persons Number : ${authProvider.listAcceptedReservations[index].number_of_people}",
                                  icon: Icons.groups),
                              Divider(
                                height: 0,
                              ),

                              buildListTile(
                                  text:
                                  "Restaurant Name : ${authProvider.listAcceptedReservations[index].name}",
                                  icon: Icons.restaurant_menu),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text:
                                  "Date Of Reservation : ${authProvider.listAcceptedReservations[index].date}",
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
                    childrenPadding: EdgeInsets.zero,
                    title: Text(AppStrings.currentReservation),
                    children: List.generate(
                        authProvider.listAcceptedReservations.length,
                            (index) => Card(
                          margin: const EdgeInsets.all(AppMargin.m8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildListTile(
                                  text:
                                  "Table Number : ${authProvider.listAcceptedReservations[index].id}",
                                  icon: Icons.table_restaurant),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text: "Persons Number : ${authProvider.listAcceptedReservations[index].number_of_people}",
                                  icon: Icons.groups),
                              Divider(
                                height: 0,
                              ),

                              buildListTile(
                                  text:
                                  "Restaurant Name : ${authProvider.listAcceptedReservations[index].name}",
                                  icon: Icons.restaurant_menu),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text:
                                  "Date Of Reservation : ${authProvider.listAcceptedReservations[index].date}",
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
                    childrenPadding: EdgeInsets.zero,
                    title: Text(AppStrings.currentReservation),
                    children: List.generate(
                        authProvider.listAcceptedReservations.length,
                            (index) => Card(
                          margin: const EdgeInsets.all(AppMargin.m8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildListTile(
                                  text:
                                  "Table Number : ${authProvider.listAcceptedReservations[index].id}",
                                  icon: Icons.table_restaurant),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text: "Persons Number : ${authProvider.listAcceptedReservations[index].number_of_people}",
                                  icon: Icons.groups),
                              Divider(
                                height: 0,
                              ),

                              buildListTile(
                                  text:
                                  "Restaurant Name : ${authProvider.listAcceptedReservations[index].name}",
                                  icon: Icons.restaurant_menu),
                              Divider(
                                height: 0,
                              ),
                              buildListTile(
                                  text:
                                  "Date Of Reservation : ${authProvider.listAcceptedReservations[index].date}",
                                  icon: Icons.date_range),
                            ],
                          ),
                        )),
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
