import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:orderbook/api/auth/auth_provider.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/translations/local_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../menu/menu_view.dart';
import '../resources/color_manager.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrView extends StatefulWidget {
  const QrView({Key? key}) : super(key: key);

  @override
  State<QrView> createState() => _QrViewState();
}

class _QrViewState extends State<QrView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  //
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderWidth: AppSize.s16,
                borderRadius: AppSize.s10,
                borderColor: ColorManager.lightPrimary),
          ),
          Positioned(
            bottom: AppSize.s20,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Container(
                padding: EdgeInsets.all(AppSize.s8),
                    decoration: BoxDecoration(
                      color: ColorManager.blackF2,
                      borderRadius: BorderRadius.circular(AppSize.s8)
                    ),
                    child: Text(
                        tr(LocaleKeys.scancode),
                        style: getLightStyle(color: ColorManager.white),
                      ),
                  ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      Get.to(()=>MenuView(id: 0,id_table: int.parse(scanData.code!) ,authProvider: Provider.of<AuthProvider>(context),));
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
