import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:orderbook/data/local/change_theme.dart';
import 'package:orderbook/data/local/storage.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../presentation/register/register_view.dart';
import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
import '../presentation/utils/user_storage_data.dart';

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key); // defualt constructor false

  MyApp._internal();

  static final _instance = MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppModel appModel = new AppModel();
  @override
  void initState() {
    super.initState();
    _initAppTheme();
  }
  void _initAppTheme() async {
    appModel.darkTheme = await AppStorage.storageRead(key: AppStorage.themeKEY);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>.value(
      value: appModel,
      child: Consumer<AppModel>(
          builder: (context, value, child) {
              return GetMaterialApp(
             debugShowCheckedModeBanner: false,
             onGenerateRoute: RoutesGenerator.getRoute,

             initialRoute: Routes.splashRoot,
             theme: getApplicationTheme(isDark: appModel.darkTheme),
           );
          }
      ),
    );
  }
}
/*
 GetMaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.splashRoot,
      theme: getApplicationTheme(isDark: Advance.theme),
    );
 */