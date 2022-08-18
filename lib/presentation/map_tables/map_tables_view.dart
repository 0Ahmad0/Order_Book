import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/presentation/add_reservations/add_reservations_view.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/restaurant_map_scroll/restaurant_map_scroll_view.dart';
import 'package:orderbook/presentation/utils/const.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:orderbook/translations/local_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:orderbook/domain/models.dart' as models;
import '../../api/auth/auth_provider.dart';
import '../../domain/models.dart';
import '../resources/style_manager.dart';

class MapTablesView extends StatefulWidget {
  final int id;
  final AuthProvider authProvider;
  int indx=-1;
  //const MapTablesView({Key? key, required this.id}) : super(key: key);
  MapTablesView({required this.id, required this.authProvider});
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
  Future<void> getTable() async {
    widget.authProvider.categories=[];
    await  widget.authProvider.table(Advance.token,widget.id);

   // print(widget.authProvider.categories.length);
  }
  void initState() {
    // TODO: implement initState
    getTable();
    super.initState();
  }
  Widget build(BuildContext context) {

    //print(widget.authProvider.listTables.length);
   // AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            if(widget.indx >=0){
              Get.to(()=>RestaurantMapScrollView(
                  widget.authProvider.listTables[widget.indx]
              ),);

            }else{
              Const.TOAST(context,textToast: tr(LocaleKeys.selectFloorFirst));
            }
          }, icon: Icon(Icons.map)),
        ],
        title: Text(tr(LocaleKeys.mapTables)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p10),
        child:Column(
          children: [
            DropdownButtonFormField<String>(
                hint: Text(tr(LocaleKeys.selectFloor)),
                items: List.generate(
                    widget.authProvider.categories.length>0?widget.authProvider.categories.length:0,
                    // floors["floors"].length,
                        (index) => DropdownMenuItem<String>(
                      child: Text("${widget.authProvider.categories[index]}"),
                      //Text("${floors["floors"][index]}"),
                      value: widget.authProvider.categories[index],//floors["floors"][index],
                    )),
                onChanged: (val) {
                  widget.indx=widget.authProvider.categories.indexOf(val!);
                  print(widget.indx);
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
              itemCount: widget.indx<0?0:(widget.authProvider.listTables[widget.indx].tables!.length>0?widget.authProvider.listTables[widget.indx].tables!.length:0),
              itemBuilder: (_,index){
                return GestureDetector(
                  onTap: () {
                     models.Table table=widget.authProvider.listTables[widget.indx].tables![index];
                   // widget.authProvider.listTables[widget.indx].tables[index]
                    Get.to(()=>AddReservationsView(table: table,));
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
                                        image: CachedNetworkImageProvider("${AppUrl.baseUrlImage}${widget.authProvider.listTables[widget.indx].tables![index].table_image}",),//AssetImage(ImagesAssets.tableImage),
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
                                        "Number Table : ${ widget.authProvider.listTables[widget.indx].tables![index].id}",
                                        //"Number Table : ${14}",
                                        style: getBoldStyle(
                                            color: ColorManager.lightPrimary,
                                            fontSize:
                                            Sizer.getW(context) * 0.04),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      Text(
                                        "Number Person : ${widget.authProvider.listTables[widget.indx].tables![index].min} - ${ widget.authProvider.listTables[widget.indx].tables![widget.indx].max}",
                                        style: getRegularStyle(
                                            color: ColorManager.black,
                                            fontSize:
                                            Sizer.getW(context) * 0.03),
                                      ),
                                      const SizedBox(
                                        height: AppSize.s10,
                                      ),
                                      /*Text(
                                        "Location : {WOOO}",
                                        style: getLightStyle(
                                            color: ColorManager.blackF2,
                                            fontSize: Sizer.getW(context) *
                                                0.03),
                                      ),*/
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),/*
                      index.isEven?   Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          ImagesAssets.reservedImage,
                          width: Sizer.getW(context) * 0.25,
                          height: Sizer.getW(context) * 0.25,
                        ),
                      ):SizedBox(),
                      */
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
