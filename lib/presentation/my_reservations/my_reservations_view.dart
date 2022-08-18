
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:orderbook/presentation/add_reservations/add_reservations_view.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:provider/provider.dart';

import '../../api/auth/auth_provider.dart';
import '../../domain/models.dart';
import '../../translations/local_keys.g.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';
import '../utils/const.dart';

class MyReservationsView extends StatefulWidget {
  //const MyReservationsView({Key? key}) : super(key: key);
  late AuthProvider authProvider;
  @override
  State<MyReservationsView> createState() => _MyReservationsViewState();
}

class _MyReservationsViewState extends State<MyReservationsView> {

  @override
  Widget build(BuildContext context) {
    widget.authProvider = Provider.of<AuthProvider>(context);
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: AppPadding.p10, horizontal: AppPadding.p20),
        child:  FutureBuilder(
          future: widget.authProvider.myReservations(Advance.token),
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
                              title: Text(tr(LocaleKeys.acceptreservation)/*AppStrings.currentReservation*/),
                              children: List.generate(
                                  widget.authProvider.listAcceptedReservations.length,
                                      (index) => Card(
                                    margin: const EdgeInsets.all(AppMargin.m8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.tableNumber)} : ${widget.authProvider.listAcceptedReservations[index].id}",
                                            icon: Icons.table_restaurant),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                            text: "${tr(LocaleKeys.personNumber)} : ${widget.authProvider.listAcceptedReservations[index].number_of_people}",
                                            icon: Icons.groups),
                                        Divider(
                                          height: 0,
                                        ),

                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.restaurantName)} : ${widget.authProvider.listAcceptedReservations[index].name}",
                                            icon: Icons.restaurant_menu),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.dateReservations)} : ${widget.authProvider.listAcceptedReservations[index].date}",
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
                              title: Text(tr(LocaleKeys.pendingReservation)/*AppStrings.currentReservation*/),
                              children: List.generate(
                                 widget.authProvider.listPendingReservations.length,
                                      (index) => Card(
                                    margin: const EdgeInsets.all(AppMargin.m8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.tableNumber)} : ${widget.authProvider.listPendingReservations[index].id}",
                                            icon: Icons.table_restaurant),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                             text: "${tr(LocaleKeys.personNumber)} : ${widget.authProvider.listPendingReservations[index].number_of_people}",
                                            icon: Icons.groups),
                                        Divider(
                                          height: 0,
                                        ),

                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.restaurantName)} : ${widget.authProvider.listPendingReservations[index].name}",
                                            icon: Icons.restaurant_menu),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.dateReservations)} : ${widget.authProvider.listPendingReservations[index].date}",
                                            icon: Icons.date_range),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: AppPadding.p8
                                              ),
                                              margin: EdgeInsets.all(AppMargin.m8),
                                              decoration: BoxDecoration(
                                                color: ColorManager.redOTP,
                                                borderRadius: BorderRadius.circular(AppSize.s4)
                                              ),
                                              child: TextButton.icon(
                                                  icon: Icon(Icons.cancel,color: ColorManager.white,),
                                                  onPressed: (){
                                                    
                                                  }, label: Text(tr(LocaleKeys.cancelOrder),
                                                style: getRegularStyle(color: ColorManager.white),)),
                                            ),
                                          ],
                                        ),
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
                              title: Text(/*AppStrings.currentReservation*/tr(LocaleKeys.rejected)),
                              children: List.generate(
                                  widget.authProvider.listRejectedReservations.length,
                                      (index) => Card(
                                    margin: const EdgeInsets.all(AppMargin.m8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.tableNumber)} : ${widget.authProvider.listRejectedReservations[index].id}",
                                            icon: Icons.table_restaurant),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                            text: "${LocaleKeys.personNumber} : ${widget.authProvider.listRejectedReservations[index].number_of_people}",
                                            icon: Icons.groups),
                                        Divider(
                                          height: 0,
                                        ),

                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.restaurantName)} : ${widget.authProvider.listRejectedReservations[index].name}",
                                            icon: Icons.restaurant_menu),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.dateReservations)} : ${widget.authProvider.listRejectedReservations[index].date}",
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
                              title: Text(tr(LocaleKeys.cancelreservation)/*AppStrings.currentReservation*/),
                              children: List.generate(
                                  widget.authProvider.listCancelledReservations.length,
                                      (index) => Card(
                                    margin: const EdgeInsets.all(AppMargin.m8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildListTile(
                                            text:
                                            "${tr(LocaleKeys.tableNumber)} : ${widget.authProvider.listCancelledReservations[index].id}",
                                            icon: Icons.table_restaurant),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                            text: "${tr(LocaleKeys.personNumber)} : ${widget.authProvider.listCancelledReservations[index].number_of_people}",
                                            icon: Icons.groups),
                                        Divider(
                                          height: 0,
                                        ),

                                        buildListTile(
                                            text:
                                            "${LocaleKeys.restaurantName} : ${widget.authProvider.listCancelledReservations[index].name}",
                                            icon: Icons.restaurant_menu),
                                        Divider(
                                          height: 0,
                                        ),
                                        buildListTile(
                                            text:
                                            "${LocaleKeys.dateReservations} : ${widget.authProvider.listCancelledReservations[index].date}",
                                            icon: Icons.date_range),
                                      ],
                                    ),
                                  )),
                            ),
                          )),
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
