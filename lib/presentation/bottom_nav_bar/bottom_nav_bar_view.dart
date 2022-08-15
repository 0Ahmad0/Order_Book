

import 'package:flutter/material.dart';
import 'package:animate_icons/animate_icons.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/about/about_view.dart';
import 'package:orderbook/presentation/home/home_view.dart';
import 'package:orderbook/presentation/login/login_view.dart';
import 'package:orderbook/presentation/my_orders/my_order_view.dart';
import 'package:orderbook/presentation/my_reservations/my_reservations_view.dart';
import 'package:orderbook/presentation/profile/profile_view.dart';
import 'package:orderbook/presentation/qr/qr_view.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/restaurant/restaurant_view.dart';
import 'package:orderbook/presentation/setting/setting_view.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:provider/provider.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../api/auth/auth_provider.dart';
import '../../data/local/change_theme.dart';
import '../../data/local/storage.dart';
import '../utils/const.dart';
import '../utils/dataLocal.dart';
class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int selectedIndex = 2;
  AnimateIconController c1 = AnimateIconController();
  late List<Map<String,dynamic>> _pages ;
  void fillList(){
    _pages = [
      {
        "title" : AppStrings.qrCode,
        "content" :QrView()
      },
      {
        "title" : AppStrings.reservations,
        "content" :MyReservationsView()
      },
      {
        "title" : AppStrings.homeText,
        "content" :HomeView()
      },
      {"title": AppStrings.restaurant,
        "content": RestaurantView()
      },
      {
        "title": AppStrings.orders,
        "content": MyOrdersView()
      },
    ];
  }
  @override
  void initState() {

    fillList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
        _pages[selectedIndex]["title"],
        ),
        actions: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              Positioned(
                top: 2.5,
                left: 2.5,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: AppSize.s10,
                  child: Text(
                    "12",
                    style:
                    getRegularStyle(color: ColorManager.black, fontSize: 10),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                     // AppStorage.storageRead(key:AppStorage.nameKEY),
                      DataLocal.user.name.isEmpty?
                      "Ahmad Alhariri":
                          DataLocal.user.name,
                      style: getRegularStyle(color: ColorManager.white),
                    ),
                    accountEmail: Text(
                      DataLocal.user.phoneNumber.isEmpty?
                      "+963 954872922":
                      DataLocal.user.phoneNumber,
                      style: getLightStyle(color: ColorManager.blackF2),
                    ),
                    currentAccountPicture: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfileView()));
                      },

                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            // gradient: LinearGradient(
                            //   colors: [
                            //     ColorManager.lightPrimary,
                            //     ColorManager.lightGray
                            //   ]
                            // ),
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(Advance.avatarImage))),
                      ),
                    ),
                    currentAccountPictureSize:
                    Size(Sizer.getW(context) * 0.18, Sizer.getW(context) * 0.18),
                    otherAccountsPictures: [
                      AnimateIcons(
                        startIconColor: Colors.white,
                        endIconColor: Colors.white,
                        startIcon:
                        appModel.darkTheme ? Icons.dark_mode : Icons.light_mode,
                        endIcon:
                        appModel.darkTheme ? Icons.dark_mode : Icons.light_mode,
                        controller: c1,
                        onStartIconPress: () {
                          appModel.darkTheme = !appModel.darkTheme;

                          return appModel.darkTheme;
                        },
                        onEndIconPress: () {
                          appModel.darkTheme = !appModel.darkTheme;

                          return appModel.darkTheme;
                        },
                      )
                    ],
                  ),
                  Hero(
                    tag: Advance.avatarImage,
                    child: buildListTileDrawer(
                        text: AppStrings.myProfile,
                        leadingIcon: Icons.account_circle,
                        traling: null,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfileView()));

                        }),
                  ),
                  Divider(
                    height: 0,
                  ),
                  buildListTileDrawer(
                      text: AppStrings.setting,
                      leadingIcon: Icons.settings,
                      traling: null,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx)=>SettingView()));
                      }),
                  Divider(
                    height: 0,
                  ),
                  buildListTileDrawer(
                      text: AppStrings.about,
                      leadingIcon: Icons.info,
                      traling: null,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx)=>AboutView()));

                      }),
                  Divider(
                    height: 0,
                  ),
                  buildListTileDrawer(
                      text: AppStrings.reports,
                      leadingIcon: Icons.report_problem,
                      traling: null,
                      onTap: () {}),
                  Divider(
                    height: 0,
                  ),
                  buildListTileDrawer(
                      text: AppStrings.logout,
                      leadingIcon: Icons.logout,
                      traling: null,
                      onTap: () async{
                        /*await AppStorage.storageWrite(
                            key: AppStorage.isLoginedKEY,
                            value: false
                        );*/
                        Const.LOADIG(context);
                        var result =await authProvider.Logout(Advance.token);
                        print(result);
                        Const.TOAST(context,textToast: result["message"]);
                        Navigator.pop(context);
                        print(Advance.token);
                        if(result["status"]){
                          Navigator.pop(context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (ctx)=>BottomNavBarView()));
                          /// SnackBar(content: Text("k"));
                          //print("done register");
                          // Const.TOAST(context,textToast: result["message"]);
                        }else{
                          /// SnackBar(content: Text("o"));

                        }

                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginView()));
                        // print(await AppStorage.storageRead(key: AppStorage.isLoginedKEY));
                      }),
                ],
              ),
              Column(
                children: [
                  Text(AppStrings.appVersion,
                    textAlign: TextAlign.center,
                    style: getLightStyle(color: ColorManager.black,),
                  ),
                  const SizedBox(height: AppSize.s10,)
                ],
              )
            ],
          )),
      bottomNavigationBar: WaterDropNavBar(
        waterDropColor: ColorManager.lightPrimary,
        inactiveIconColor: ColorManager.lightGray,
        bottomPadding: 5,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.qr_code,
            outlinedIcon: Icons.qr_code,
          ),
          BarItem(
              filledIcon: Icons.table_restaurant,
              outlinedIcon: Icons.table_restaurant),
          BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home),
          BarItem(
              filledIcon: Icons.restaurant_menu,
              outlinedIcon: Icons.restaurant_menu),
          BarItem(filledIcon: Icons.grading, outlinedIcon: Icons.grading),
        ],
      ),
      body: _pages[selectedIndex]["content"],

    );
  }
  Widget buildListTileDrawer({text, leadingIcon, traling, onTap}) {
    return ListTile(
      title: Text(
        text,
        style: getRegularStyle(color: ColorManager.black),
      ),
      leading: Icon(leadingIcon),
      trailing: traling,
      onTap: onTap,
    );
  }

}
