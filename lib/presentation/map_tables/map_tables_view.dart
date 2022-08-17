import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/presentation/add_reservations/add_reservations_view.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/const.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';

import '../../api/auth/auth_provider.dart';
import '../resources/style_manager.dart';

class MapTablesView extends StatefulWidget {
  const MapTablesView({Key? key}) : super(key: key);

  @override
  State<MapTablesView> createState() => _MapTablesViewState();
}

class _MapTablesViewState extends State<MapTablesView> {
  Map<String, dynamic> floors = {
    "floors": [
      "First Floor",
      "Second Floor",
      "Third Floor",
      "Fourth Floor",
      "Fifth Floor",
    ]
  };
  bool refresh = true;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.mapTables),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p10),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
                hint: Text(AppStrings.selectFloor),
                items: List.generate(
                    floors["floors"].length,
                    (index) => DropdownMenuItem<String>(
                          child: Text("${floors["floors"][index]}"),
                          value: floors["floors"][index],
                        )),
                onChanged: (val) {
                  Timer(
                    Duration(seconds: 1),
                      (){
                      refresh = true;
                      setState((){});
                      }
                  );
                  refresh = false;
                  setState((){});

                }),
            const SizedBox(height: AppSize.s20,),
           refresh? Expanded(child: ListView.builder(
              itemCount: 15,
              itemBuilder: (_,index){
                return GestureDetector(
                  onTap: () {
                    Get.to(()=>AddReservationsView());
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        margin:
                        const EdgeInsets.symmetric(vertical: AppMargin.m8),
                        decoration: BoxDecoration(
                          color: ColorManager.lightGray.withOpacity(.2),
                            borderRadius: BorderRadius.circular(AppSize.s14),
                           ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  width: Sizer.getW(context) * 0.25,
                                  height: Sizer.getW(context) * 0.25,
                                  decoration: BoxDecoration(
                                      color: ColorManager.lightPrimary
                                          .withOpacity(.8),
                                      borderRadius: BorderRadius.circular(
                                          AppSize.s14),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(ImagesAssets.tableImage),
                                      )
                                  ),
                                )),
                            SizedBox(
                              width: AppSize.s10,
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        "Number Table : ${14}",
                                        style: getBoldStyle(
                                            color: ColorManager.lightPrimary,
                                            fontSize:
                                            Sizer.getW(context) * 0.04),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Text(
                                        "Number Person : ${16}",
                                        style: getRegularStyle(
                                            color: ColorManager.black,
                                            fontSize:
                                            Sizer.getW(context) * 0.03),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Text(
                                        "Location : {WOOO}",
                                        style: getLightStyle(
                                            color: ColorManager.blackF2,
                                            fontSize: Sizer.getW(context) *
                                                0.03),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                   index.isEven?   Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          ImagesAssets.reservedImage,
                          width: Sizer.getW(context) * 0.25,
                          height: Sizer.getW(context) * 0.25,
                        ),
                      ):SizedBox(),
                    ],
                  ),
                );
              },
            ))
               :SizedBox()
          ],
        ),
      ),
    );
  }
}
