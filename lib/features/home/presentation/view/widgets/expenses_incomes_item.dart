import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/features/expenses_income/data/models/expenses_income_model.dart';
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

  final List<ExpensesIncomeModel> expensesIncomesModel;
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
    return Card(
      color: Colors.lime.shade100,
      elevation: 4,
      shadowColor: Colors.lime,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: 20.w,
                left: 20.w,
                top: 20.h,
                bottom: widget.today != null ? 0 : 25.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.today != null) ...[
                    Text(tr('Today'),
                        style: AppStyles.styleMedium12
                            .copyWith(color: AppColors.color424242)),
                  ] else ...[
                    Text(
                      '${MethodsHelper.convert(context, widget.expensesIncomesModel[0].day!)} / ${MethodsHelper.convert(context, widget.expensesIncomesModel[0].month!)} / ${MethodsHelper.convert(context, widget.expensesIncomesModel[0].year!)}',
                      style: AppStyles.styleRegular14,
                    ),
                  ],
                  Text(
                      MethodsHelper.convert(
                          context, widget.amountPerDay.toString()),
                      style: AppStyles.styleRegular14
                          .copyWith(color: AppColors.color424242))
                ]),
          ),
          if (widget.today == null) ...[
            if (widget.expensesIncomesModel.length >= 2) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ExpensesIncomesSmallItem(
                  expensesIncomesModel: widget.expensesIncomesModel[
                      widget.expensesIncomesModel.length - 1],
                ),
              ),
            ],
            SizedBox(height: 15.h),
            if (widget.expensesIncomesModel.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ExpensesIncomesSmallItem(
                  expensesIncomesModel: widget.expensesIncomesModel[0],
                ),
              ),
            ],
          ] else ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ExpensesIncomesSmallItem(
                        expensesIncomesModel:
                            widget.expensesIncomesModel[index],
                      ),
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  itemCount: widget.expensesIncomesModel.length),
            ),
          ],
          SizedBox(height: 25.h),
          const ExpesesIncomesDivider(count: 60),
          SizedBox(height: 5.h),
          TextButton(
              onPressed: widget.onTap,
              child: Text(
                tr('MoreDetails'),
                style: AppStyles.styleRegular14.copyWith(color: Colors.teal),
              )),
              SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
