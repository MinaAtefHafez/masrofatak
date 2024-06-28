import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/core/widgets/custom_bottom_sheet.dart';
import 'package:masrofatak/core/widgets/custom_elevated_button.dart';
import 'package:masrofatak/core/widgets/custom_snack_bar.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_states.dart';
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
  late final TextEditingController categoryTextController;
  final categoryCubit = getIt<CategoryCubit>();
  final expensesIncomeCubit = getIt<ExpensesIncomeCubit>();

  @override
  void initState() {
    super.initState();
    categoryTextController =
        TextEditingController(text: categoryCubit.getCategory.name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpensesIncomeCubit, ExpensesIncomeState>(
      bloc: expensesIncomeCubit,
      listener: (context, state) {
        if (state is GetExpensesIncomesLocal) {
          CustomNavigator.pop();
          CustomSnackBar.customSnackBar(context, text: tr('AddDoneSuccess'));
        }
      },
      child: BlocListener<CategoryCubit, CategoryState>(
        bloc: categoryCubit,
        listener: (context, state) {
          if (state is ChooseCategory) {
            categoryTextController.text = categoryCubit.getCategory.name!;
          }
        },
        child: Scaffold(
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
                    BlocBuilder<ExpensesIncomeCubit, ExpensesIncomeState>(
                      bloc: expensesIncomeCubit,
                      builder: (context, state) {
                        return ExpensesIncomeButton(
                          isExpense: expensesIncomeCubit.isExpense,
                          onTapExpenses: expensesIncomeCubit.onChooseExpenses,
                          onTapIncome: expensesIncomeCubit.onChooseIncome,
                        );
                      },
                    ),
                    SizedBox(height: 30.h),
                    BlocBuilder<CategoryCubit, CategoryState>(
                      bloc: categoryCubit,
                      builder: (context, state) {
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
                      },
                    ),
                    SizedBox(height: 30.h),
                    ExpensesIncomeTextField(
                      inputType: TextInputType.number,
                      hint: tr('EnterAmount'),
                      onChanged: (value) {
                        expensesIncomeCubit.onAmountChanged(value.trim());
                      },
                    ),
                    SizedBox(height: 30.h),
                    ExpensesIncomeTextField(
                      hint: tr('Description'),
                      onChanged: expensesIncomeCubit.onDescriptionChanged,
                    ),
                    SizedBox(height: 50.h),
                    BlocBuilder<ExpensesIncomeCubit, ExpensesIncomeState>(
                      bloc: expensesIncomeCubit,
                      builder: (context, state) {
                        return CustomElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await expensesIncomeCubit.addExpensesOrIncome();
                              }
                            },
                            text: expensesIncomeCubit.isExpense
                                ? tr('AddExpenses')
                                : tr('AddIncome'),
                            size: Size(158.w, 32.h));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
