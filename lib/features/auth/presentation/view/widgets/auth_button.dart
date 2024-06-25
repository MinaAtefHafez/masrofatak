import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 40.h,
        width: 248.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(
              color: AppColors.colorBDBDBD,
              width: 1.w,
            )),
        child: Text(tr('SignUpWithGoogle'),
            style: AppStyles.styleRegular14
                .copyWith(color: Colors.blue, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
