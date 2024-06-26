import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

abstract class CustomSnackBar {
  static customSnackBar(BuildContext context,
      {required String text, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text,
          style:
              AppStyles.styleRegular14.copyWith(color: AppColors.color424242)),
      backgroundColor: color ?? Colors.green,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
    ));
  }
}
