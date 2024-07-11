import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/app_styles/app_styles.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/enums/enums.dart';
import '../../../../../core/helpers/methos_helper/methods_helper.dart';

class ExpensesIncomesSmallItem extends StatelessWidget {
  const ExpensesIncomesSmallItem(
      {super.key,
      required this.expensesIncomesModel,
      
      this.isWidgetIntrinsic = false});

  final dynamic expensesIncomesModel;
  final bool isWidgetIntrinsic;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15.r) 
                            ),
          child: UnconstrainedBox(
            child: SvgPicture.asset(
              expensesIncomesModel.category!.icon!,
              width: 22.w,
              height: 22.w,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expensesIncomesModel.description!,
                style: AppStyles.styleRegular14.copyWith(
                    color: AppColors.color424242, fontWeight: FontWeight.w300),
                maxLines: isWidgetIntrinsic ? null : 1,
                overflow: isWidgetIntrinsic ? null : TextOverflow.ellipsis,
              ),
              Text(
                expensesIncomesModel.category!.name!,
                style: AppStyles.styleMedium12.copyWith(color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text(
          getMoneyType(expensesIncomesModel.type!) == MoneyType.expenses
              ? MethodsHelper.convert(context, expensesIncomesModel.amount.toString())
              : MethodsHelper.convert(context, expensesIncomesModel.amount.toString()),
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
