import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

class ExpensesIncomeButton extends StatelessWidget {
  const ExpensesIncomeButton(
      {super.key,
      required this.onTapExpenses,
      required this.isExpense,
      required this.onTapIncome});

  final Function() onTapExpenses;
  final Function() onTapIncome;
  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 40.h,
      decoration: BoxDecoration(
          color: AppColors.colorF5F5F5,
          borderRadius: BorderRadius.circular(50.r)),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: onTapExpenses,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isExpense
                      ? Colors.blue.withOpacity(0.6)
                      : AppColors.colorF5F5F5,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(50.r))),
              child: Text(tr('Expenses'), style: AppStyles.styleRegular14),
            ),
          )),
          VerticalDivider(
              thickness: 2.w,
              width: 0,
              color: AppColors.color424242.withOpacity(0.5)),
          Expanded(
              child: InkWell(
            onTap: onTapIncome,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isExpense
                      ? AppColors.colorF5F5F5
                      : Colors.blue.withOpacity(0.6),
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(50.r))),
              child: Text(tr('Income'), style: AppStyles.styleRegular14),
            ),
          ))
        ],
      ),
    );
  }
}
