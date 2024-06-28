import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/enums/enums.dart';
import 'package:masrofatak/features/home/presentation/manager/home_cubit.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../categories/presentation/manager/category_cubit.dart';

class ExpensesIncomesItem extends StatefulWidget {
  const ExpensesIncomesItem(
      {super.key,
      required this.expensesIncomesModel,
      this.today, required this.amountPerDay,});

  final List<dynamic> expensesIncomesModel;
  final String? today;
  final int amountPerDay ;

  @override
  State<ExpensesIncomesItem> createState() => _ExpensesIncomesItemState();
}

class _ExpensesIncomesItemState extends State<ExpensesIncomesItem> {
  final categoryCubit = getIt<CategoryCubit>();
  final homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      height: 230.h,
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
                    : widget.expensesIncomesModel[0].day,
                style: widget.today != null
                    ? AppStyles.styleMedium12
                        .copyWith(color: AppColors.color424242)
                    : AppStyles.styleRegular14
                        .copyWith(color: AppColors.color424242)),
            Text(widget.amountPerDay.toString(),
                style: AppStyles.styleMedium12
                    .copyWith(color: AppColors.color424242))
          ]),
          if (widget.expensesIncomesModel.isNotEmpty) ...[
            SizedBox(height: 15.h),
            ExpensesIncomesSmallItem(
                expensesIncomesModel: widget.expensesIncomesModel[0],
                color: categoryCubit.getCategoryColor),
          ],
          SizedBox(height: 15.h),
          if (widget.expensesIncomesModel.length >= 2) ...[
            ExpensesIncomesSmallItem(
                expensesIncomesModel: widget.expensesIncomesModel[1],
                color: categoryCubit.getCategoryColor),
          ],
          SizedBox(height: 15.h),
          if (widget.expensesIncomesModel.length >= 3) ...[
            ExpensesIncomesSmallItem(
                expensesIncomesModel: widget.expensesIncomesModel[2],
                color: categoryCubit.getCategoryColor)
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
