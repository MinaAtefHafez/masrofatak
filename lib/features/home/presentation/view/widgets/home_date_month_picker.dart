import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

import '../../../../../core/app_styles/app_styles.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/gen/app_images.dart';

class DateMonthPickerItem extends StatelessWidget {
  const DateMonthPickerItem(
      {super.key,
      required this.onTapLeft,
      required this.onTapRight,
      required this.onTap});

  final Function() onTapLeft;
  final Function() onTapRight;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: onTapLeft,
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.color000000,
                size: 25.w,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            width: 124.w,
            decoration: BoxDecoration(
              color: AppColors.colorF5F5F5,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.imagesCalendarToday,
                  width: 16.w,
                  height: 16.h,
                ),
                SizedBox(width: 10.w),
                Text('May , 2024',
                    style: AppStyles.styleRegular14.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.color424242))
              ],
            ),
          ),
          IconButton(
              onPressed: onTapRight,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.color000000,
                size: 25.w,
              ))
        ],
      ),
    );
  }
}
