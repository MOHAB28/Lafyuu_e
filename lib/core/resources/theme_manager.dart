import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'styles_manager.dart';
import 'font_manager.dart';
import 'values_manager.dart';
import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.white,
      elevation: 0.3,
      iconTheme: const IconThemeData(color: ColorManager.grey),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      titleTextStyle: getBoldStyle(
        color: ColorManager.dark,
        fontSize: FontSize.s16,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorManager.white,
    ),
    textTheme: TextTheme(
      titleLarge: getBoldStyle(
        color: ColorManager.dark,
        fontSize: FontSize.s20,
      ),
      titleMedium: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s14,
      ),
      titleSmall: getBoldStyle(
        color: ColorManager.blue,
      ),
      displayMedium: getBoldStyle(
        color: ColorManager.dark,
        fontSize: FontSize.s16,
      ),
      displaySmall: getRegularStyle(color: ColorManager.grey),
      headlineLarge: getBoldStyle(
        color: ColorManager.dark,
        fontSize: FontSize.s24,
      ),
      headlineSmall: getBoldStyle(color: ColorManager.dark),
      bodySmall:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s10),
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: ColorManager.blue,
      textColor: ColorManager.dark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: getRegularStyle(color: ColorManager.grey),
      errorStyle: getBoldStyle(
        color: ColorManager.red,
      ),
      suffixIconColor: ColorManager.grey,
      prefixIconColor: ColorManager.grey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide:
            const BorderSide(color: ColorManager.light, width: AppSize.s1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide:
            const BorderSide(color: ColorManager.light, width: AppSize.s1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.s5),
        borderSide:
            const BorderSide(color: ColorManager.blue, width: AppSize.s1),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.white,
      elevation: AppSize.s1,
      selectedItemColor: ColorManager.blue,
      selectedIconTheme: const IconThemeData(color: ColorManager.blue),
      unselectedIconTheme: const IconThemeData(color: ColorManager.grey),
      unselectedItemColor: ColorManager.grey,
      unselectedLabelStyle: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s10,
      ),
      selectedLabelStyle: getBoldStyle(
        color: ColorManager.blue,
        fontSize: FontSize.s10,
      ),
    ),
  );
}
