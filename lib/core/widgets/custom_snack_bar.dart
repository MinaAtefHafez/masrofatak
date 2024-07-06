import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

abstract class CustomSnackBar {
  static customSnackBar(BuildContext context,
      {required String text, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Text(tr(text),
          style: AppStyles.styleRegular14.copyWith(color: Colors.white)),
      backgroundColor: color ?? AppColors.color424242,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none),
    ));
  }
}
