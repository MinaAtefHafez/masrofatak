import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import 'package:masrofatak/core/helpers/methos_helper/methods_helper.dart';
import 'dart:ui' as ui;

import '../../../../../core/app_styles/app_styles.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/gen/app_images.dart';

class DateMonthPickerItem extends StatelessWidget {
  const DateMonthPickerItem(
      {super.key,
      required this.onTapLeft,
      required this.onTapRight,
      required this.onTap,
      required this.month});

  final Function() onTapLeft;
  final Function() onTapRight;
  final Function() onTap;
  final String month;

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
                color: AppColors.color424242,
                size: 25.w,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                Text(
                    '${tr(month)} ${MethodsHelper.convert(context, IntlHelper.yearNow)}',
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
                color: AppColors.color424242,
                size: 25.w,
              ))
        ],
      ),
    );
  }
}
