import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:intl/intl.dart';
import 'package:orderbook/translations/local_keys.g.dart';
import 'package:provider/provider.dart';

import '../../api/app_url/app_url.dart';
import '../../api/auth/auth_provider.dart';
import '../../domain/models.dart';
import '../login/login_view.dart';
import '../resources/strings_manager.dart';
import 'package:orderbook/domain/models.dart' as models;

import '../utils/const.dart';

class AddReservationsView extends StatefulWidget {
  //const AddReservationsView({Key? key}) : super(key: key);
  final models.Table table;
  AddReservationsView({required this.table});
  @override
  State<AddReservationsView> createState() => _AddReservationsViewState();
}

class _AddReservationsViewState extends State<AddReservationsView> {
  final personNumber = TextEditingController();
  final tableNumber = TextEditingController(text: "0");
  final dateReservations = TextEditingController(text: "${
  DateFormat.yMd().format(DateTime.now())
  }");
  @override
  void initState() {
   print(widget.table.table_number);
    numPerson=widget.table.min!;
    personNumber.text="${widget.table.min}";
    // TODO: implement initState
    super.initState();
  }
  final reviews = TextEditingController();
   DateTime _selectedDate = DateTime.now();
  int numPerson = 1;
  @override
  Widget build(BuildContext context) {
     AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Add Reservations"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p10),
        child: Column(
          children: [
                Container(
                  height: Sizer.getH(context) * 0.25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        "${AppUrl.baseUrlImage}${widget.table.table_image}"
                        ,),//AssetImage(ImagesAssets.tableImage)
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.6),
                        blurRadius: 8.0,
                        offset: Offset(0, 4)),
                  ]),
            ),
            const SizedBox(height: AppSize.s20,),
            Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSize.s8
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s14),
                          color: ColorManager.lightGray.withOpacity(.2)
                        ),
                        child: ListTile(
                          title: Text(
                            tr(LocaleKeys.tableNumber),
                            style: getRegularStyle(
                              color: ColorManager.lightPrimary,
                              fontSize: Sizer.getW(context) * 0.035
                            ),
                          ),
                          trailing: SizedBox(
                            height:Sizer.getW(context) * 0.1 ,
                            width: Sizer.getW(context) * 0.25,
                              child: TextFormField(initialValue: "${widget.table.table_number}",
                                // controller: tableNumber,
                                cursorColor: ColorManager.lightPrimary,
                                style: getRegularStyle(
                                    color: ColorManager.lightPrimary,
                                  fontSize: Sizer.getW(context) * 0.03
                                ),
                                readOnly: true,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  fillColor: ColorManager.white,
                                ),
                              )
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSize.s8
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s14),
                          color: ColorManager.lightGray.withOpacity(.2)
                        ),
                        child: ListTile(
                          title: Text(
                              tr(LocaleKeys.personNumber),
                            style: getRegularStyle(
                              color: ColorManager.lightPrimary,
                              fontSize: Sizer.getW(context) * 0.035
                            ),
                          ),
                          trailing: SizedBox(
                            height:Sizer.getW(context) * 0.1 ,
                            width: Sizer.getW(context) * 0.25,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      if(numPerson>widget.table.min!)
                                        numPerson--;
                                      personNumber.text = numPerson.toString();

                                      setState((){});
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: ColorManager.lightPrimary,
                                      radius: Sizer.getW(context) * 0.03,
                                      child: Icon(Icons.remove,color: Colors.white,),
                                    ),
                                  ),
                                  SizedBox(width: AppSize.s6,),
                                  Expanded(
                                    child: TextFormField(
                                      controller: personNumber,
                                      cursorColor: ColorManager.lightPrimary,
                                      style: getRegularStyle(
                                          color: ColorManager.lightPrimary,
                                        fontSize: Sizer.getW(context) * 0.03
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        filled: true,
                                        fillColor: ColorManager.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppSize.s6,),
                                  InkWell(
                                    onTap: (){
                                      if(numPerson<widget.table.max!)
                                        numPerson++;
                                      personNumber.text = numPerson.toString();
                                      setState((){});
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: ColorManager.lightPrimary,
                                      radius: Sizer.getW(context) * 0.03,
                                      child: Icon(Icons.add,color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSize.s8
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s14),
                          color: ColorManager.lightGray.withOpacity(.2)
                        ),
                        child: ListTile(
                          title: Text(
                            tr(LocaleKeys.dateReservations),
                            style: getRegularStyle(
                              color: ColorManager.lightPrimary,
                              fontSize: Sizer.getW(context) * 0.035
                            ),
                          ),
                          trailing: SizedBox(
                            height:Sizer.getW(context) * 0.1 ,
                            width: Sizer.getW(context) * 0.25,
                              child:
                              TextFormField(
                                readOnly: true,
                                onTap: (){
                                  _selectDate(context);
                                },
                                controller: dateReservations,
                                cursorColor: ColorManager.lightPrimary,
                                style: getRegularStyle(
                                    color: ColorManager.lightPrimary,
                                    fontSize: Sizer.getW(context) * 0.03
                                ),
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  fillColor: ColorManager.white,
                                ),
                              ),

                              )
                          ),

                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: AppSize.s8
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s14),
                          color: ColorManager.lightGray.withOpacity(.2)
                        ),
                        child: ListTile(
                          title: Text(
                            tr(LocaleKeys.reviews),
                            style: getRegularStyle(
                              color: ColorManager.lightPrimary,
                              fontSize: Sizer.getW(context) * 0.035
                            ),
                          ),
                         subtitle:TextFormField(
                           controller: reviews,
                           cursorColor: ColorManager.lightPrimary,
                           style: getRegularStyle(
                               color: ColorManager.lightPrimary,
                               fontSize: Sizer.getW(context) * 0.03
                           ),
                           minLines: 1,
                           maxLines: 3,
                           maxLength: 200,
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.all(AppSize.s8),
                             filled: true,
                             fillColor: ColorManager.white,
                           ),
                         ),
                          ),

                      ),
                      const SizedBox(height: AppSize.s10,),
                      ButtonApp(
                        text: "Add Reservations",
                        onTap: () async {
                          Const.LOADIG(context);
                          Map<String, dynamic> result ={"message":"","status":""};
                          result =await authProvider.addReservations(Advance.token, widget.table.id!,numPerson,
                              "2022-08-22 16:00",reviews.text);
                          print(result);
                          Const.TOAST(context,textToast: result["message"]);
                          Navigator.pop(context);
                          if(result["status"]){
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
              primarySwatch: Colors.orange
          ),
          child: child!,
        );
      },
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
        );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      dateReservations
        ..text = DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: dateReservations.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}


