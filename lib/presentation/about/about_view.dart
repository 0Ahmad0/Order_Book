import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orderbook/presentation/resources/assets_manager.dart';
import 'package:orderbook/presentation/resources/color_manager.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/style_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import 'package:share_plus/share_plus.dart';

class AboutView extends StatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Share.share(
              'Download OrderBook From \n https://www.OrderBook.com/downloads/app.apk');
        },
        child: Icon(Icons.share),
      ),
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        title: Text(AppStrings.about),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p20,
        ),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: AppSize.s10),
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s6),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    ImagesAssets.splashLogo,
                    width: Sizer.getW(context) * 0.1,
                    height: Sizer.getW(context) * 0.1,
                  ),
                  title: Text(AppStrings.appName),
                ),

                buildListTile(
                  onTap: () {},
                  icon: Icons.info,
                  title: "V1.0.0",
                ),
                Divider(
                  height: 0.0,
                ),
                buildListTile(
                    onTap: () {}, icon: Icons.cached, title: "Changelog"),
                Divider(
                  height: 0.0,
                ),
                buildListTile(
                    onTap: () {}, icon: Icons.download_done, title: "License"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: AppSize.s10),
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),

            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s6),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text("Author"),
                ),
                buildListTile(
                  onTap: () {},
                  icon: Icons.person,
                  title: "OrderBook",
                  subtitle: "Syria",
                ),
                Divider(
                  height: 0.0,
                ),
                buildListTile(
                    onTap: () {},
                    icon: Icons.download,
                    title: "Download From Cloud"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: AppSize.s10),
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),

            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s6),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text("Company"),
                ),
                buildListTile(
                    onTap: () {},
                    icon: Icons.work,
                    title: "ITE-Info",
                    subtitle: "Syria"),
                Divider(
                  height: 0.0,
                ),
                buildListTile(
                    onTap: () {},
                    icon: Icons.location_pin,
                    title: "Location",
                    subtitle: "Syria-Damascus"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildListTile({title, subtitle, icon, onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(title,style: getRegularStyle(color: ColorManager.lightPrimary,
        fontSize: Sizer.getW(context) * 0.035
      ),),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: getLightStyle(color: ColorManager.black),
            ),
      leading: Icon(icon),
    );
  }
}
