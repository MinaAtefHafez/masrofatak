import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';
import 'package:masrofatak/core/widgets/custom_elevated_button.dart';
import '../../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../categories/presentation/manager/category_cubit.dart';
import '../../manager/expenses_income_cubit.dart';

class ExpensesCategoryBottomSheerWidget extends StatefulWidget {
  const ExpensesCategoryBottomSheerWidget(
      {super.key, required this.categories, required this.addNewCategory});

  final List<dynamic> categories;
  final Function() addNewCategory;

  @override
  State<ExpensesCategoryBottomSheerWidget> createState() =>
      _ExpensesCategoryBottomSheerWidgetState();
}

class _ExpensesCategoryBottomSheerWidgetState
    extends State<ExpensesCategoryBottomSheerWidget> {
  final categoryCubit = getIt<CategoryCubit>();
  final expensesIncomeCubit = getIt<ExpensesIncomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(tr('ChooseCategory'),
            style: AppStyles.styleMedium13
                .copyWith(color: AppColors.color424242)),
        SizedBox(height: 20.h),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            padding: EdgeInsets.zero,
            itemCount: widget.categories.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  expensesIncomeCubit
                      .chooseCategory(widget.categories[index]);
                },
                child: Column(
                  children: [
                    UnconstrainedBox(
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: UnconstrainedBox(
                          child: SvgPicture.asset(
                            widget.categories[index].icon!,
                            width: 32.w,
                            height: 32.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      widget.categories[index].name!,
                      style: AppStyles.styleMedium12,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        CustomElevatedButton(
          onPressed: widget.addNewCategory,
          text: 'AddNewCategory',
          size: Size(158.w, 32.h),
        ),
      ],
    );
  }
}
