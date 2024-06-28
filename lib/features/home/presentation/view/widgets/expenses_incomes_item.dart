import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/enums/enums.dart';
import 'package:masrofatak/features/expenses_income/data/models/expenses_income_model.dart';

import '../../../../../core/app_theme/colors/app_colors.dart';

class ExpensesIncomesItem extends StatelessWidget {
  const ExpensesIncomesItem(
      {super.key, required this.expensesIncomesModel, required this.color});

  final ExpensesIncomeModel expensesIncomesModel;
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
            Text('Today',
                style: AppStyles.styleMedium12
                    .copyWith(color: AppColors.color424242)),
            Text('11.500',
                style: AppStyles.styleMedium12
                    .copyWith(color: AppColors.color424242))
          ]),
          SizedBox(height: 10.h),
          Row(
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
                    color: getMoneyType(expensesIncomesModel.type!) ==
                            MoneyType.incomes
                        ? AppColors.color00897B
                        : AppColors.colorE53935),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
