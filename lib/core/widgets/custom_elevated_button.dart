import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_styles/app_styles.dart';
import '../app_theme/colors/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.size,
      this.color});

  final Function() onPressed;
  final String text;
  final Size size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.color007BEF,
            minimumSize: size,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h)),
        child: Text(
          tr(text),
          style: AppStyles.styleRegular14.copyWith(color: Colors.white),
        ));
  }
}
