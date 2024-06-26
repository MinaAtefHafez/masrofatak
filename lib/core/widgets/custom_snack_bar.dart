import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

abstract class CustomSnackBar {
  static customSnackBar(BuildContext context,
      {required String text, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4 ),
      padding: EdgeInsets.symmetric(horizontal: 15.w , vertical: 5.h  ),
      
      content: Text(text,
          style:
              AppStyles.styleMedium12.copyWith(color: AppColors.color424242)),
      backgroundColor: color ?? Colors.green,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
    ));
  }
}
