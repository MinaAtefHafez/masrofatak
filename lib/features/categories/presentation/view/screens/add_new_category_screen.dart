import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/core/widgets/custom_bottom_sheet.dart';
import 'package:masrofatak/core/widgets/custom_elevated_button.dart';
import 'package:masrofatak/core/widgets/custom_snack_bar.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_states.dart';
// ignore: unused_import
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_statesd.dart';
import 'package:masrofatak/features/expenses_income/presentation/view/widgets/expenses_income_text_field.dart';
import 'package:masrofatak/features/search/presentation/manager/search_cubit.dart';

import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../expenses_income/presentation/view/widgets/expenses_income_button.dart';
import '../../../../expenses_income/presentation/view/widgets/expensescategory_icons_bottom_sheet.dart';
import '../../manager/category_cubit.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  static const name = '/addNewCategory';

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  final categoryCubit = getIt<CategoryCubit>();
  final searchCubit = getIt<SearchCubit>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('AddNewCategory')),
      ),
      body: BlocConsumer<CategoryCubit, CategoryState>(
        bloc: categoryCubit,
        listener: (context, state) {
          if (state is OnCategoryIconChanged) {
            CustomNavigator.pop();
          }

          if (state is GetIncomesCategoriesLocal) {
            CustomSnackBar.customSnackBar(context, text: 'AddDoneSuccess');
            CustomNavigator.pop(2);
            searchCubit.getExpensesIncomesFromExpensesCubit(state.categories);
          }

          if (state is GeExpensesCategoriesLocal) {
            searchCubit
                .getExpensesCategoriesFromCategoryCubit(state.categories);
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  ExpensesIncomeButton(
                    isExpense: categoryCubit.isExpenses,
                    onTapExpenses: categoryCubit.onTapExpenses,
                    onTapIncome: categoryCubit.onTapIncomes,
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          customBottomSheet(context,
                              widget: CategoriesIconsBottomSheerWidget(
                                  icons: categoryCubit.categoriesIcons));
                        },
                        child: Container(
                          width: 60.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle),
                          child: UnconstrainedBox(
                            child: Container(
                              width: 35.w,
                              height: 35.h,
                              decoration: const BoxDecoration(
                                  color: AppColors.color616161,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      if (categoryCubit.categoryModel.icon != null) ...[
                        Container(
                          width: 40.w,
                          height: 40.h,
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15.r) 
                            ),
                          child: SvgPicture.asset(
                            categoryCubit.categoryModel.icon!,
                            width: 25.w,
                            height: 25.h,
                          ),
                        ),
                      ],
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: ExpensesIncomeTextField(
                            onChanged: categoryCubit.onCategoryNameChanged,
                            label: tr('CategoryName'),
                            readOnly: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (categoryCubit.categoryModel.icon == null) {
                            CustomSnackBar.customSnackBar(context,
                                text: 'ShouldAddIcon');
                            return;
                          }
                          await categoryCubit.addToExpensesOrIncomes();
                          await categoryCubit.saveExpensesCategoriesLocal();
                          await categoryCubit.saveIncomesCategoriesLocal();
                          await categoryCubit.getExpensesCategoriesLocal();
                          await categoryCubit.getIncomesCategoriesLocal();
                        }
                      },
                      text: 'AddNewCategory',
                      size: const Size(250, 30)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
