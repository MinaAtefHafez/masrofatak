import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/helpers/methos_helper/methods_helper.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/expenses_income/data/models/expenses_income_model.dart';

import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/enums/enums.dart';

class SearchExpensesIncomesItem extends StatefulWidget {
  const SearchExpensesIncomesItem(
      {super.key, required this.expensesIncomeModel});

  final ExpensesIncomeModel expensesIncomeModel;

  @override
  State<SearchExpensesIncomesItem> createState() =>
      _SearchExpensesIncomesItemState();
}

class _SearchExpensesIncomesItemState extends State<SearchExpensesIncomesItem> {
  final categoryCubit = getIt<CategoryCubit>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15.r)),
          child: UnconstrainedBox(
            child: SvgPicture.asset(
              widget.expensesIncomeModel.category!.icon!,
              width: 24.w,
              height: 24.w,
            ),
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.expensesIncomeModel.description!,
                style: AppStyles.styleRegular14.copyWith(
                    color: AppColors.color424242, fontWeight: FontWeight.w300),
              ),
              Text(
                widget.expensesIncomeModel.category!.name!,
                style: AppStyles.styleMedium12.copyWith(color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getMoneyType(widget.expensesIncomeModel.type!) ==
                      MoneyType.expenses
                  ? '-${MethodsHelper.convert(context, widget.expensesIncomeModel.amount.toString())}'
                  : '+${MethodsHelper.convert(context, widget.expensesIncomeModel.amount.toString())}',
              style: AppStyles.styleRegular14.copyWith(
                  color: getMoneyType(widget.expensesIncomeModel.type!) ==
                          MoneyType.incomes
                      ? AppColors.color00897B
                      : AppColors.colorE53935),
            ),
            Text(
              MethodsHelper.convert(context,
                  '${widget.expensesIncomeModel.day} / ${widget.expensesIncomeModel.month} / ${widget.expensesIncomeModel.year}'),
            )
          ],
        ),
      ],
    );
  }
}
