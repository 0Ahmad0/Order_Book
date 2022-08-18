import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/api/app_url/app_url.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../translations/local_keys.g.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.mapTables)),
      ),
      body: Zoom(
        maxZoomHeight: 1200 ,
        maxZoomWidth: 1200,
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.fill,
              width: double.infinity,
              height: Sizer.getW(context) * 0.7,
              imageUrl:
              "${AppUrl.baseUrlImage}${widget.tables.image}",
              // "https://static.vecteezy.com/system/resources/previews/000/134/503/original/free-vector-food-illustration.jpg",
              imageBuilder: (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        //    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                      ),
                    ),
                  ),
              placeholder: (context, url) =>
                  CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error),
            ),
            Container(
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
                    top: double.parse(widget.tables.tables![index].top!)
                    *(index==0?(index+1):index)* widget.tables.tables!.length/3

                    /** (index+1)*5*/,
                    left: double.parse(widget.tables.tables![index].left!)
                        *(index==0?(index+1):index)* widget.tables.tables!.length / 3
                    /** (index+1) * 2.5*/,
                    child: GestureDetector(
                      onTap: () {
                        var table = widget.tables.tables![index];
                        Get.to(() => AddReservationsView(
                              table: table,
                            ));
                      },
                      child: Icon(
                        Icons.table_restaurant,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
