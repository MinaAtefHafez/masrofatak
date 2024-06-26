import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/widgets/custom_bottom_sheet.dart';
import 'package:masrofatak/core/widgets/custom_elevated_button.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_statesd.dart';
import 'package:masrofatak/features/expenses_income/presentation/view/widgets/expenses_income_button.dart';

import '../../manager/expenses_income_cubit.dart';
import '../widgets/expenses_category_bottom_sheet.dart';
import '../widgets/expenses_income_text_field.dart';

class AddExpensesIncomeScreen extends StatefulWidget {
  const AddExpensesIncomeScreen({super.key});

  static const name = '/addExpensesIncome';

  @override
  State<AddExpensesIncomeScreen> createState() =>
      _AddExpensesIncomeScreenState();
}

class _AddExpensesIncomeScreenState extends State<AddExpensesIncomeScreen> {
  final formKey = GlobalKey<FormState>();
  final categoryTextController = TextEditingController(text: 'fsdfsdfsd');
  final categoryCubit = getIt<CategoryCubit>();
  final expensesIncomeCubit = getIt<ExpensesIncomeCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesIncomeCubit, ExpensesIncomeState>(
      bloc: expensesIncomeCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.colorF5F5F5,
            title: Text(tr('AddNew')),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ExpensesIncomeButton(
                      isExpense: expensesIncomeCubit.isExpense,
                      onTapExpenses: expensesIncomeCubit.onChooseExpenses,
                      onTapIncome: expensesIncomeCubit.onChooseIncome,
                    ),
                    SizedBox(height: 30.h),
                    Builder(builder: (context) {
                      return ExpensesIncomeTextField(
                        controller: categoryTextController,
                        label: tr('CategoryName'),
                        readOnly: true,
                        onTap: () {
                          customBottomSheet(context,
                              widget: ExpensesCategoryBottomSheerWidget(
                                categories: categoryCubit.categories,
                              ));
                        },
                      );
                    }),
                    SizedBox(height: 30.h),
                    ExpensesIncomeTextField(
                      inputType: TextInputType.number,
                      hint: tr('EnterAmount'),
                      onChanged: (value) {
                        value = value.replaceAll('', '0');
                        expensesIncomeCubit.onAmountChanged(value);
                      },
                    ),
                    SizedBox(height: 30.h),
                    ExpensesIncomeTextField(
                      hint: tr('Description'),
                      onChanged: expensesIncomeCubit.onDescriptionChanged,
                    ),
                    SizedBox(height: 50.h),
                    CustomElevatedButton(
                        onPressed: () {},
                        text: expensesIncomeCubit.isExpense
                            ? tr('AddExpenses')
                            : tr('AddIncome'),
                        size: Size(158.w, 32.h))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}