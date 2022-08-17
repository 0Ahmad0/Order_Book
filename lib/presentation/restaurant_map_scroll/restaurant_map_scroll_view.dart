import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../add_reservations/add_reservations_view.dart';
import '../resources/strings_manager.dart';
import '../utils/sizer.dart';

class RestaurantMapScrollView extends StatefulWidget {
  Tables tables;

  RestaurantMapScrollView(this.tables);

  @override
  State<RestaurantMapScrollView> createState() =>
      _RestaurantMapScrollViewState();
}

class _RestaurantMapScrollViewState extends State<RestaurantMapScrollView> {
  Map data = {
    "data": [
      {
        "id": 4,
        "name": "Priscilla Yost",
        "image":
            "/storage/app/public/vendorsMaps/Y5iPWITFQkz8tIvjlVRVNyFEqvSgS2NIkG152pCj.png",
        "tables": [
          {
            "id": 22,
            "top": "150.8196",
            "left": "20.63",
            "table_image":
                "/storage/app/public/tables/SxqMcC3YWOKDp3m0IQwhBAXIKmSeHWnEyhF5q1mO.png",
            "max": "5",
            "min": "1",
            "qrCode": "storage/app/public/QrCodes/22.png"
          },
          {
            "id": 23,
            "top": "300.454324",
            "left": "89.924",
            "table_image":
                "/storage/app/public/tables/rTm3RSrG35VHOlfbEWdjtoPl7vfvc961GAOE0rT9.png",
            "max": "5",
            "min": "1",
            "qrCode": "storage/app/public/QrCodes/23.png"
          },
          {
            "id": 24,
            "top": "60.796610654",
            "left": "104.79940367",
            "table_image":
                "/storage/app/public/tables/1CZFaO3wqNJkJ8qK2FjjF1zMZhCpYmRdpe5pZKnC.png",
            "max": "9",
            "min": "4",
            "qrCode": "storage/app/public/QrCodes/24.png"
          },
          {
            "id": 25,
            "top": "10.673",
            "left": "366.662",
            "table_image":
                "/storage/app/public/tables/uHXJwVJttwFv35oTKM8PKlwz1RGbcyfdWfxKKtBE.png",
            "max": "6",
            "min": "4",
            "qrCode": "storage/app/public/QrCodes/25.png"
          },
          {
            "id": 26,
            "top": "202.13921597",
            "left": "0.150",
            "table_image":
                "/storage/app/public/tables/SRIxGjHkILR2HPDjxRPUPnsQ4FTJUeVLEGYMXl1N.png",
            "max": "7",
            "min": "1",
            "qrCode": "storage/app/public/QrCodes/26.png"
          }
        ]
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    print(widget.tables);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.mapTables),
      ),
      body: Zoom(
        maxZoomHeight: Sizer.getH(context),
        maxZoomWidth: Sizer.getW(context) + 100,
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.blackF2.withOpacity(.2),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(
                  "${AppUrl.baseUrlImage}${widget.tables.image}"
              )
            ),
          ),
          child: Stack(
            children: List.generate(
              widget.tables.tables!.length,
              (index) => Positioned(
                top: double.parse(widget.tables.tables![index].top!) ,
                left: double.parse(widget.tables.tables![index].left!),
                child: GestureDetector(
                  onTap: () {
                    var table = widget.tables.tables![index];
                    Get.to(() => AddReservationsView(
                          table: table,
                        ));
                  },
                  child: Icon(
                    Icons.table_restaurant,
                    size: Sizer.getW(context) * 0.25,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
