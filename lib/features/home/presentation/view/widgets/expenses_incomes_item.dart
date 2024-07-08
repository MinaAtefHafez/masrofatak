import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/features/home/presentation/manager/home_cubit.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/helpers/methos_helper/methods_helper.dart';
import '../../../../categories/presentation/manager/category_cubit.dart';
import 'expenses_incomes_divider.dart';
import 'expenses_incomes_small_item.dart';

class ExpensesIncomesItem extends StatefulWidget {
  const ExpensesIncomesItem({
    super.key,
    required this.expensesIncomesModel,
    this.today,
    required this.amountPerDay,
    required this.onTap,
  });

  final List<dynamic> expensesIncomesModel;
  final String? today;
  final int amountPerDay;
  final Function() onTap;

  @override
  State<ExpensesIncomesItem> createState() => _ExpensesIncomesItemState();
}

class _ExpensesIncomesItemState extends State<ExpensesIncomesItem> {
  final categoryCubit = getIt<CategoryCubit>();
  final homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.colorE0E0E0, width: 1.w),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                  widget.today != null
                      ? tr('Today')
                      : '${MethodsHelper.convert(context, widget.expensesIncomesModel[0].day)} / ${MethodsHelper.convert(context, widget.expensesIncomesModel[0].month)}',
                  style: widget.today != null
                      ? AppStyles.styleMedium12
                          .copyWith(color: AppColors.color424242)
                      : AppStyles.styleRegular14
                          .copyWith(color: AppColors.color424242)),
              Text(
                  MethodsHelper.convert(
                      context, widget.amountPerDay.toString()),
                  style: AppStyles.styleRegular14
                      .copyWith(color: AppColors.color424242))
            ]),
            if (widget.expensesIncomesModel.length >= 2) ...[
              ExpensesIncomesSmallItem(
                  expensesIncomesModel: widget.expensesIncomesModel[
                      widget.expensesIncomesModel.length - 1],
                  color: categoryCubit.getCategoryColor),
            ],
            SizedBox(height: 15.h),
            if (widget.expensesIncomesModel.isNotEmpty) ...[
              ExpensesIncomesSmallItem(
                  expensesIncomesModel: widget.expensesIncomesModel[0],
                  color: categoryCubit.getCategoryColor),
            ],
            SizedBox(height: 25.h),
            const ExpesesIncomesDivider(count: 50),
            SizedBox(height: 5.h),
            Expanded(
              child: TextButton(
                  onPressed: widget.onTap,
                  child: Text(
                    tr('MoreDetails'),
                    style: AppStyles.styleRegular14
                        .copyWith(color: AppColors.color424242),
                  )),
            )
          ],
        ),
      ),
    );
  }
}


