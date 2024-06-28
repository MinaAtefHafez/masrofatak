import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/enums/enums.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';

class ExpensesIncomesItem extends StatelessWidget {
  const ExpensesIncomesItem(
      {super.key, required this.expensesIncomesModel, required this.color});

  final List<dynamic> expensesIncomesModel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      height: 216.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.colorE0E0E0, width: 1.w),
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
                IntlHelper.dayNow != expensesIncomesModel[0].day
                    ? tr('Today')
                    : expensesIncomesModel[0].day,
                style: AppStyles.styleMedium12
                    .copyWith(color: AppColors.color424242)),
            Text('11.500',
                style: AppStyles.styleMedium12
                    .copyWith(color: AppColors.color424242))
          ]),
          if (expensesIncomesModel.isNotEmpty) ...[
            SizedBox(height: 15.h),
            ExpensesIncomesSmallItem(
                expensesIncomesModel: expensesIncomesModel[0], color: color),
          ],
          SizedBox(height: 15.h),
          if (expensesIncomesModel.length >= 2) ...[
            ExpensesIncomesSmallItem(
                expensesIncomesModel: expensesIncomesModel[1], color: color),
          ],
          SizedBox(height: 15.h),
          if (expensesIncomesModel.length >= 3) ...[
            ExpensesIncomesSmallItem(
                expensesIncomesModel: expensesIncomesModel[2], color: color)
          ],
        ],
      ),
    );
  }
}

class ExpensesIncomesSmallItem extends StatelessWidget {
  const ExpensesIncomesSmallItem(
      {super.key, required this.expensesIncomesModel, required this.color});

  final dynamic expensesIncomesModel;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: UnconstrainedBox(
            child: SvgPicture.asset(
              expensesIncomesModel.category!.icon!,
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expensesIncomesModel.description!,
                style: AppStyles.styleRegular14
                    .copyWith(color: AppColors.color212121),
              ),
              Text(
                expensesIncomesModel.category!.name!,
                style: AppStyles.styleMedium12
                    .copyWith(color: AppColors.color616161),
              ),
            ],
          ),
        ),
        Text(
          getMoneyType(expensesIncomesModel.type!) == MoneyType.expenses
              ? '-${expensesIncomesModel.amount}'
              : '+${expensesIncomesModel.amount}',
          style: AppStyles.styleRegular14.copyWith(
              color:
                  getMoneyType(expensesIncomesModel.type!) == MoneyType.incomes
                      ? AppColors.color00897B
                      : AppColors.colorE53935),
        ),
      ],
    );
  }
}
