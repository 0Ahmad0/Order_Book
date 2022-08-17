import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:intl/intl.dart';

import '../../api/app_url/app_url.dart';
import '../login/login_view.dart';
import '../resources/strings_manager.dart';
import 'package:orderbook/domain/models.dart' as models;

class AddReservationsView extends StatefulWidget {
  //const AddReservationsView({Key? key}) : super(key: key);
  final models.Table table;
  AddReservationsView({required this.table});
  @override
  State<AddReservationsView> createState() => _AddReservationsViewState();
}

class _AddReservationsViewState extends State<AddReservationsView> {
  final personNumber = TextEditingController(text: "1");
  final tableNumber = TextEditingController(text: "0");
  final dateReservations = TextEditingController(text: "${
  DateFormat.yMd().format(DateTime.now())
  }");
  final reviews = TextEditingController();
   DateTime _selectedDate = DateTime.now();
  int numPerson = 1;
  @override
  Widget build(BuildContext context) {
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
                      image: CachedNetworkImageProvider("${AppUrl.baseUrlImage}${widget.table.table_image}",),//AssetImage(ImagesAssets.tableImage)
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
                            AppStrings.tableNumber,
                            style: getRegularStyle(
                              color: ColorManager.lightPrimary,
                              fontSize: Sizer.getW(context) * 0.035
                            ),
                          ),
                          trailing: SizedBox(
                            height:Sizer.getW(context) * 0.1 ,
                            width: Sizer.getW(context) * 0.25,
                              child: TextFormField(initialValue: "${widget.table.table_number}",
                                controller: tableNumber,
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
                            AppStrings.personNumber,
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
                                      if(numPerson>1)
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
                            AppStrings.dateReservations,
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
                            AppStrings.reviews,
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
                        onTap: (){
                          Get.dialog(
                              Center(
                                child: Container(
                                    alignment: Alignment.center,
                                    width: Sizer.getW(context) * 0.2,
                                    height: Sizer.getW(context) * 0.2,
                                    decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(AppSize.s8)
                                    ),
                                    child: LoadingAnimationWidget.inkDrop(
                                        color: ColorManager.lightPrimary,
                                        size:Sizer.getW(context) * 0.1
                                    )
                                ),
                              )
                          );
                          Timer(Duration(seconds: 1),(){
                            Navigator.pop(context);
                            Get.defaultDialog(
                                backgroundColor: ColorManager.white4,
                                title: "Successful ccessful AddSuccessful AddSuccessful AddSuccessful AddSuccessful Add",
                                titleStyle: getRegularStyle(
                                    color: ColorManager.black,
                                    fontSize: Sizer.getW(context) * 0.04),
                                content: Icon(
                                  Icons.check_circle,
                                  size: AppSize.s60,
                                  color: ColorManager.success,
                                ),
                                radius: 4.0);
                          });
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


