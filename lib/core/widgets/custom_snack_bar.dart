import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';

abstract class CustomSnackBar {
  static customSnackBar(BuildContext context,
      {required String text, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      elevation: 0,
      content: Row(
        children: [
          const Icon(Icons.done, color: Colors.green),
          SizedBox(width: 5.w),
          Text(tr(text),
              style: AppStyles.styleRegular14.copyWith(color: Colors.white)),
        ],
      ),
      backgroundColor: color ?? Colors.green,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
          borderSide: BorderSide.none),
    ));
  }
}
