import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/helpers/methos_helper/methods_helper.dart';
import 'package:masrofatak/features/home/data/models/all_money_model.dart';

import '../../../../../core/app_styles/app_styles.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/gen/app_images.dart';

class HomeBasicItem extends StatelessWidget {
  const HomeBasicItem({super.key, required this.allMoney});

  final AllMoneyModel allMoney;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3 ,
      color: Colors.blue.shade50 ,
      shadowColor: Colors.grey.shade500 ,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            ),
        height: 100.h,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.imagesExpenses,
                      width: 24.w, height: 24.h),
                  Text(
                      MethodsHelper.convert(
                          context, allMoney.expenses.toString()),
                      style: AppStyles.styleRegular14.copyWith(
                          color: AppColors.colorE53935,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
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
                  SvgPicture.asset(Assets.imagesBalance,
                      width: 24.w, height: 24.h),
                  Text(
                      MethodsHelper.convert(
                          context, allMoney.balance.toString()),
                      style: AppStyles.styleRegular14.copyWith(
                          color: AppColors.color616161,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
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
                  SvgPicture.asset(Assets.imagesIncome,
                      width: 24.w, height: 24.h),
                  Text(
                      MethodsHelper.convert(context, allMoney.incomes.toString()),
                      style: AppStyles.styleRegular14.copyWith(
                          color: AppColors.color00897B,
                          fontWeight: FontWeight.w500)),
                  Text(
                    tr('Income'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.styleRegular14
                        .copyWith(color: AppColors.color616161),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
