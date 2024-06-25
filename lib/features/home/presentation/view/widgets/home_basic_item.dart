



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/app_styles/app_styles.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/gen/app_images.dart';

class HomeBasicItem extends StatelessWidget {
  const HomeBasicItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.colorE0E0E0, width: 1.w)),
      height: 100.h,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Assets.imagesExpenses,
                    width: 24.w, height: 24.h),
                Text('-12,000',
                    style: AppStyles.styleRegular14.copyWith(
                        color: AppColors.colorE53935,
                        fontWeight: FontWeight.w500)),
                Text(
                  tr('Expenses'),
                  style: AppStyles.styleRegular14
                      .copyWith(color: AppColors.color616161),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Assets.imagesExpenses,
                    width: 24.w, height: 24.h),
                Text('-12,000',
                    style: AppStyles.styleRegular14.copyWith(
                        color: AppColors.color616161,
                        fontWeight: FontWeight.w500)),
                Text(
                  tr('Balance'),
                  style: AppStyles.styleRegular14
                      .copyWith(color: AppColors.color616161),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Assets.imagesExpenses,
                    width: 24.w, height: 24.h),
                Text('-12,000',
                    style: AppStyles.styleRegular14.copyWith(
                        color: AppColors.color00897B,
                        fontWeight: FontWeight.w500)),
                Text(
                  tr('Income'),
                  style: AppStyles.styleRegular14.copyWith(color: AppColors.color616161),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}