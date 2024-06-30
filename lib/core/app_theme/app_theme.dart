import 'package:flutter/material.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

abstract class AppTheme {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,

      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle:
              AppStyles.styleRegular16.copyWith(color: AppColors.color424242),
          actionsIconTheme: const IconThemeData(
            color: Colors.black,
          )),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        elevation: 5,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(
          applyTextScaling: true,
          color: AppColors.color424242,
        ),
        unselectedIconTheme: IconThemeData(
          applyTextScaling: true,
          color: AppColors.color424242,
        ),
      ),
      fontFamily: 'Inter');

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.grey.shade300,
        elevation: 5,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        elevation: 5,
        selectedIconTheme: IconThemeData(
          applyTextScaling: true,
          color: AppColors.color424242,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedIconTheme: IconThemeData(
          applyTextScaling: true,
          color: AppColors.color424242,
        ),
      ),
      fontFamily: 'Inter');
}
