import 'package:animate_icons/animate_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderbook/data/local/storage.dart';
import 'package:orderbook/domain/models.dart';
import 'package:orderbook/presentation/resources/strings_manager.dart';
import 'package:orderbook/presentation/resources/values_manager.dart';
import 'package:orderbook/translations/local_keys.g.dart';
import 'package:provider/provider.dart';

import '../../data/local/change_theme.dart';
import '../resources/color_manager.dart';
import '../resources/style_manager.dart';
import '../utils/sizer.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool language = false;
  bool theme = false;
  late AnimateIconController c1 = AnimateIconController();
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.setting)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p10,
          horizontal: AppPadding.p20,
        ),
        child: Column(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent
              ),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: AppSize.s8
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    color: ColorManager.lightGray.withOpacity(.2)
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.only(
                    right: Advance.language?AppSize.s16:0,
                    left: Advance.language?0:AppSize.s16,
                  ),
                  title: ListTile(
                    title: Text(
                      tr(LocaleKeys.language),
                      style: getRegularStyle(
                          color: ColorManager.lightPrimary,
                          fontSize: Sizer.getW(context) * 0.035
                      ),
                    ),
                    leading: Icon(Icons.language),
                    subtitle: Text(
                    Advance.language
                        ? tr(LocaleKeys.englishText)
                        :tr(LocaleKeys.arabicText)
                    ,style: getLightStyle(
                        color: ColorManager.darkPrimary
                    ),),

                  ),
                  children: [
                    ListTile(
                      onTap: ()async{
                        final _newLocale = Locale('en');
                        await context.setLocale(_newLocale);
                        Get.updateLocale(_newLocale);
                        // setState((){});
                        // print(context.locale);
                        Advance.language = true;
                        await AppStorage.storageWrite(
                          key: AppStorage.languageKEY,
                          value: true
                        );
                        setState((){});
                      },
                      title: Text(tr(LocaleKeys.englishText),style: getRegularStyle(color: ColorManager.lightPrimary,
                      fontSize: Sizer.getW(context) * 0.035,
                      ),),
                      leading: SizedBox(),
                      trailing: Switch(
                        value: Advance.language,
                        onChanged: (val)async{

                          //
                          final _newLocale = Locale('en');
                          await context.setLocale(_newLocale);
                          Get.updateLocale(_newLocale);
                          Advance.language = true;
                          await AppStorage.storageWrite(
                              key: AppStorage.languageKEY,
                              value: true
                          );
                          setState((){});
                          },
                      ),

                    ),
                    ListTile(
                      onTap: ()async{
                        final _newLocale = Locale('ar');
                        await context.setLocale(_newLocale);
                        Get.updateLocale(_newLocale);
                        // print(context.locale);
                        Advance.language = false;
                        await AppStorage.storageWrite(
                            key: AppStorage.languageKEY,
                            value: false
                        );
                        setState((){});
                      },
                      title: Text(tr(LocaleKeys.arabicText),style: getRegularStyle(color: ColorManager.lightPrimary,
                        fontSize: Sizer.getW(context) * 0.035,
                      ),),
                      leading: SizedBox(),
                      trailing: Switch(
                        value: !Advance.language,
                        onChanged: (val)async{
                          final _newLocale = Locale('ar');
                          await context.setLocale(_newLocale);
                          Get.updateLocale(_newLocale);
                          // //
                          Advance.language = false;
                          await AppStorage.storageWrite(
                              key: AppStorage.languageKEY,
                              value: false
                          );

                          setState((){});
                        },
                      ),
                    ),

                  ],
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
                  tr(LocaleKeys.theme),
                  style: getRegularStyle(
                      color: ColorManager.lightPrimary,
                      fontSize: Sizer.getW(context) * 0.035
                  ),
                ),
                  subtitle: Text(
                  appModel.darkTheme
                      ? tr(LocaleKeys.darkMode)
                      :tr(LocaleKeys.lightMode)
                  ,style: getLightStyle(
                      color: ColorManager.darkPrimary
                  ),),
                leading: Icon(Icons.color_lens_outlined),
                trailing: AnimateIcons(
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
              ),

            ),
            // Text(tr(LocaleKeys.language),style: getBoldStyle(color: ColorManager.redOTP),)
          ],
        ),
      ),
    );
  }
}
