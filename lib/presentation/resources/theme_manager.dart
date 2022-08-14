import 'package:flutter/material.dart';
import 'package:orderbook/presentation/utils/sizer.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';
import '../../presentation/resources/style_manager.dart';
import '../../presentation/resources/values_manager.dart';
import 'strings_manager.dart';
class MyTheme{
  static final lightTheme = ThemeData.light().copyWith(
        //Icon Theme
        iconTheme: IconThemeData(
          color: ColorManager.lightPrimary,
        ),
        //timePicker
        //Divider Theme
        dividerTheme: DividerThemeData(

          color: ColorManager.lightSecondary,
        ),

        //Drawer Theme
        drawerTheme: DrawerThemeData(
            backgroundColor: ColorManager.white,
        ),

        //scaffold Color
        scaffoldBackgroundColor: ColorManager.white,

        //main Color

        primaryColor: ColorManager.lightPrimary,
        primaryColorLight: ColorManager.lightSecondary,
        primaryColorDark: ColorManager.darkPrimary,
        disabledColor: ColorManager.lightGray,
        splashColor: ColorManager.lightPrimary,
    //CardView Theme
        cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.lightGray,
          elevation: AppSize.s4,
        ),
        //AppBar Theme
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: ColorManager.lightPrimary,
            iconTheme: IconThemeData(
              color: ColorManager.white,
            ),
            elevation: AppSize.s4,
            shadowColor: ColorManager.lightPrimary,
            titleTextStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16)
        ),


        //Button Theme
        buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.lightGray,
          buttonColor: ColorManager.lightPrimary,
          splashColor: ColorManager.lightPrimary,
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
              alignment: Alignment.centerLeft,
              primary: ColorManager.lightPrimary,
              textStyle: getLightStyle(color: ColorManager.lightPrimary),

            )

        ),
        //elvatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s17),
              primary: ColorManager.lightPrimary,
              minimumSize: Size(double.infinity, AppSize.s60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8)
              )
          ),
        ),

        //Text Theme
        textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(color: ColorManager.lightGray,fontSize: FontSize.s22),
          headlineLarge: getSemiBoldStyle(color: ColorManager.lightGray,fontSize: FontSize.s16),
          headlineMedium: getRegularStyle(color: ColorManager.lightGray,fontSize: FontSize.s14),
          titleMedium: getMediumStyle(color: ColorManager.lightPrimary,fontSize: FontSize.s16),
          bodyLarge: getRegularStyle(color: ColorManager.lightPrimary,),
          bodySmall: getRegularStyle(color: ColorManager.lightPrimary,),
        ),

        //InputDecoration Theme
        inputDecorationTheme: InputDecorationTheme(
          //padding
          // contentPadding:const EdgeInsets.all(AppPadding.p8),
          //hint
          hintStyle: getRegularStyle(color: ColorManager.lightGray , fontSize: FontSize.s14),
          //label
          labelStyle: getMediumStyle(color: ColorManager.lightGray , fontSize: FontSize.s14),
          //error
          errorStyle: getRegularStyle(color: ColorManager.error , fontSize: FontSize.s14),

          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.lightPrimary,
                width: AppSize.s1_5,
              ),
              borderRadius: BorderRadius.circular(AppSize.s8)

          ),

          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.lightGray,
                width: AppSize.s1_5,
              ),
              borderRadius: BorderRadius.circular(AppSize.s8)

          ),

          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.error,
                width: AppSize.s1_5,
              ),
              borderRadius: BorderRadius.circular(AppSize.s8)

          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: ColorManager.lightPrimary,
                width: AppSize.s1_5,
              ),
              borderRadius: BorderRadius.circular(AppSize.s8)
          ),
        ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorManager.blackF2,
        //main Color
        primaryColor: ColorManager.darkPrimary,
        primaryColorLight: ColorManager.darkSecondary,
        primaryColorDark: ColorManager.darkPrimary,
        disabledColor: ColorManager.darkPrimary,
        splashColor: ColorManager.darkPrimary,

        //CardView Theme
        cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.lightGray,
          elevation: AppSize.s4,
        ),


        //AppBar Theme
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: ColorManager.darkPrimary,
            elevation: AppSize.s4,
            iconTheme: IconThemeData(
                color: Colors.amber
            ),
            shadowColor: ColorManager.lightPrimary,
            titleTextStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16)
        ),


        //Button Theme
        buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.lightGray,
          buttonColor: ColorManager.lightPrimary,
          splashColor: ColorManager.lightPrimary,
        ),

        //elvatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s17),
              primary: ColorManager.lightPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)
              )
          ),
        ),

        //Text Theme
        textTheme: TextTheme(
          displayLarge: getSemiBoldStyle(color: ColorManager.lightGray,fontSize: FontSize.s22),
          headlineLarge: getSemiBoldStyle(color: ColorManager.lightGray,fontSize: FontSize.s16),
          headlineMedium: getRegularStyle(color: ColorManager.lightGray,fontSize: FontSize.s14),
          titleMedium: getMediumStyle(color: ColorManager.lightPrimary,fontSize: FontSize.s16),
          bodyLarge: getRegularStyle(color: ColorManager.lightPrimary,),
          bodySmall: getRegularStyle(color: ColorManager.lightPrimary,),
        ),

        //InputDecoration Theme
        inputDecorationTheme: InputDecorationTheme(
          //padding
          // contentPadding:const EdgeInsets.all(AppPadding.p8),
          //hint
          hintStyle: getRegularStyle(color: ColorManager.lightGray , fontSize: FontSize.s14),
          //label
          labelStyle: getMediumStyle(color: ColorManager.lightGray , fontSize: FontSize.s14),
          //error
          errorStyle: getRegularStyle(color: ColorManager.error , fontSize: FontSize.s14),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.lightPrimary,
              // width: AppSize.s1_5,
            ),
            // borderRadius: BorderRadius.circular(AppSize.s8)

          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.lightGray,
              // width: AppSize.s1_5,
            ),
            // borderRadius: BorderRadius.circular(AppSize.s8)

          ),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.error,
              // width: AppSize.s1_5,
            ),
            // borderRadius: BorderRadius.circular(AppSize.s8)

          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.lightPrimary,
              // width: AppSize.s1_5,
            ),
            // borderRadius: BorderRadius.circular(AppSize.s8)

          ),



        ),



  );

}
ThemeData getApplicationTheme({bool isDark = false}){
  return isDark ? MyTheme.darkTheme : MyTheme.lightTheme;
}